class PagesController < ApplicationController
  def home
  	@skills = Skill.where(active: true).limit(3)
  end

  def search
  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
  	end

   if session[:loc_search] && session[:loc_search] != ""
      @skills_address = Skill.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @skills_address = Skill.where(active: true).all
    end


  	@search = @skills_address.ransack(params[:q])
  	@skills = @search.result

  	@arrSkills = @skills.to_a
  	if (params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty?)
  		start_date = Date.parse(params[:start_date])
  		end_date = Date.parse(params[:end_date])

  		@skills.each do |skill|
  			not_available = skill.reservations.where(
  				"(? <= start_date AND start_date <= ?) 
  				OR (? <= start_date AND start_date <= ?)
  				OR (start_date < ? AND ? < end_date)",
  				start_date, end_date,
  				start_date, end_date,
  				start_date, end_date
  				).limit(1)
  			if not_available.length < 0
  				@arrSkills.delete(skill)
  			end
  		end
  	end
  end
end
