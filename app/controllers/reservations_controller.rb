class ReservationsController < ApplicationController
	before_action :authenticate_user!

	def create
		skill = Skill.find(params[:skill_id])

		if current_user == skill.user
			flash[:alert] = "You cannot hire yourself!"
		else
	     start_date = Date.parse(reservation_params[:start_date])
	     end_date = Date.parse(reservation_params[:end_date])
	     days = (end_date - start_date).to_i + 1

			@reservation = current_user.reservations.build(reservation_params)
			@reservation.skill = skill
			@reservation.price = skill.price
			@reservation.total = skill.price * days
			@reservation.save

			flash[:notice] = "Hired Sucessfully!"
		end
		redirect_to skill
	end

	def your_trips
		@trips = current_user.reservations.order(start_date: :asc)
	end

	def your_reservations
		@skills = current_user.skills
	end

	private

		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date)	
		end

end






























