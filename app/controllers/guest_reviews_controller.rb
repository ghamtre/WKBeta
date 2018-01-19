class GuestReviewsController < ApplicationController

	def create
		@reservation = Reservation.where(
                    id: guest_review_params[:reservation_id],
                    skill_id: guest_review_params[:skill_id]
                   ).first
		if !@reservation.nil? && @reservation.skill.id == guest_review_params[:host_id].to_i
			@has_reviewed = GuestReview.where(
				reservation_id: @reservation.id,
				host_id: guest_review_params[:host_id]
				).first
		if @has_reviewed.nil?
			#Allow  to review
			@guest_review = current_user.guest_reviews.create(guest_review_params)
			flash[:success] = "You made a review."
		else
			#Already reviewed
			flash[:success] = "You already made a review."
		end
		else
			flash[:alert] = "Reservation not founded."
		end

		redirect_back(fallback_location: request.referer)
	end

	def destroy
		@guest_review = Review.find(params[:id])
		@guest_review.destroy

		redirect_back(fallback_location: request.referer, notice: "Review has been deleted!")
	end
	private	
		def guest_review_params
			params.require(:guest_review).permit(:comment, :star, :skill_id, :reservation_id, :host_id)
		end
end