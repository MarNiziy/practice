class UsersController < ApplicationController

    def index
      @users = User.all
    end

  	def show
  		@user = User.find(params[:id])
      @posts = current_user.posts.order(created_at: :desc)
  	end

  	def edit
      	@user = User.find(params[:id])

    end

  	def update
    	@user = User.find(params[:id])
    	if user.update(user_update_params)
    		redirect_to user_path(@user), flash: { success: "Post was updated" }
    	else
    		render :edit
  	   end
    end

  	private

  	def user_update_params
  		params.require(:user).permit(:email, :name)
  	end
end

