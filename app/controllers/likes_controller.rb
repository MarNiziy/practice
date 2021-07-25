class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :load_user 

	def create
    @like = current_user.likes.build(like_params)
    @post = Post.find(params[:post_id])

    if @like.save
      redirect_to user_post_path(@user, @post)
    end
  end

  def destroy
  	@post = Post.find(params[:post_id])
    @like = current_user.likes.where(post_id: @post).take
    
    @like.destroy
    redirect_to user_post_path(@user, @post)
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end
  def like_params
    params.permit :post_id
  end
end
