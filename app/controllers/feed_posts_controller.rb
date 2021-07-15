class FeedPostsController < ApplicationController
	before_action :authenticate_user! 

	def index
		if current_user.followings.exists?
			@user = User.find(current_user.followings.pluck(:id))
			@posts = Post.where(user_id: current_user.followings.pluck(:id)).order(created_at: :desc)
		end
	end
end
