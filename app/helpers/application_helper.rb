module ApplicationHelper
	def avatar_url(user)
		if user.image 
			"https://graph.facebook.com/#{user.uid}/picture?type=large"
		else
			gravatar_id = Digest::MD5::hexdigest(user.email).downcase
			"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=https://pbs.twimg.com/profile_images/828356677929992193/Q90G6zgv_400x400.jpg"
		end
	end
end
