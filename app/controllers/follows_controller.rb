class FollowsController < ApplicationController
	before_action :authenticate_user!

	def create
    	if !current_user.followings.include?(User.find(params[:following_id]))
			@user = User.find(params[:following_id])
			follower_user = current_user
			following_user = User.find(params[:following_id])

			Follow.create(follower: follower_user, following: following_user)

			redirect_to user_path(@user)
        end
    end

    def destroy
		if current_user.followings.include?(User.find(params[:id]))
			@follower_id = current_user.id
			@following_id = current_user.followings.find(params[:id]).id
			@follow = Follow.where(follower_id: @follower_id, following_id: @following_id).take
			@follow.destroy

			redirect_to user_path(params[:id])
		end
	end
end
