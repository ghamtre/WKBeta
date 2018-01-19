class PhotosController < ApplicationController

	def create
		@skill = Skill.find(params[:skill_id])

		if params[:images]
			params[:images].each do |img|
				@skill.photos.create(image: img)
			end
			@photos = @skill.photos
			if @skill.save
				redirect_back(fallback_location: request.referer, notice: "Saved...")
			else
				redirect_back(fallback_location: request.referer, alert: "One of your photos is larger than 2 MB.")
			end
		end
	end

	def destroy
		@photo = Photo.find(params[:id])
	    @skill = @photo.skill

	    @photo.destroy
	    @photos = Photo.where(skill_id: @skill.id)

	    respond_to :js
	end
end