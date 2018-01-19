class SkillsController < ApplicationController
  before_action :set_skill, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorized, only: [:listing, :pricing, :description, :photo_upload, :perks, :location, :update]
  def index
    @skills = current_user.skills
  end

  def new
    @skill = current_user.skills.build
  end

  def create
    @skill = current_user.skills.build(skill_params)
    if @skill.save
      redirect_to listing_skill_path(@skill), notice: "Saved..."
    else
      flash[:alert] = @skill.errors.full_messages[0]
      render :new 
    end
  end

  def show
    @photos = @skill.photos
    @guest_reviews = @skill.guest_reviews
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @skill.photos
  end

  def perks
  end

  def location
  end

  def update
    new_params = skill_params
    new_params = skill_params.merge(active: true) if is_ready_skill

    if @skill.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:alert] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referer)
  end

  # --- Reservations ---
  def preload
    today = Date.today
    reservations = @skill.reservations.where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @skill)
    }

    render json: output
  end

  private
    def is_conflict(start_date, end_date, skill)
      check = skill.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
    end

    def set_skill
      @skill = Skill.find(params[:id])
    end

    def is_ready_skill
      !@skill.active && !@skill.price.blank? && !@skill.skill_name.blank? && !@skill.photos.blank? && !@skill.portfolio.blank?
    end

    def is_authorized
      redirect_to root_path, alert: "You don't have permission to do that!" unless current_user.id == @skill.user_id
    end

    def skill_params
      params.require(:skill).permit(:category_type, :skill_type, :perk, :day_hour, :skill_name, :summary, :portfolio, :is_skype,
        :is_ip,:is_discord,:is_steam,:is_fi,:price, :active, :address)
    end
end



































