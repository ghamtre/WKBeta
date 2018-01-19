class HostReviewsController < ApplicationController

	def create
		@reservation = Reservation.where(
			id: host_review_params[:reservation_id],
			skill_id: host_review_params[:skill_id],
			user_id: host_review_params[:guest_id]
			).first
		if !@reservation.nil?
			@has_reviewed = HostReview.where(
				reservation_id: @reservation.id,
				guest_id: host_review_params[:guest_id]
				).first
		if @has_reviewed.nil?
			#Allow  to review
			@host_review = current_user.host_reviews.create(host_review_params)
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
		@host_review = Review.find(params[:id])
		@host_review.destroy

		redirect_back(fallback_location: request.referer, notice: "Review has been deleted!")
	end
	private	
		def host_review_params
			params.require(:host_review).permit(:comment, :star, :skill_id, :reservation_id, :guest_id)
		end
end