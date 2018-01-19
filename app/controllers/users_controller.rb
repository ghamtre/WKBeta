class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@skills = @user.skills

		#Display all the reviews to wooklier (if this user is a wooklier)
		@guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)

		#Display all the reviews to patron (if this user is a patron)
		@host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
	end
end