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
    @user.update(user_update_params)
    redirect_to user_path(@user)
  end

  private

  def user_update_params
  	params.require(:user).permit(:email, :name, :username, :image)
  end
end

