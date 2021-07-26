class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :load_user, :load_post 

	def create
    @like = current_user.likes.build(like_params)
    @post = @like.post

    if @like.save
      redirect_to user_post_path(@user, @post)
    end
  end

  def destroy
    @like = current_user.likes.where(post_id: @post).take
    @post = @like.post
    
    @like.destroy
    redirect_to user_post_path(@user, @post)
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_post
    @post = Post.find(params[:post_id])
  end

  def like_params
    params.permit(:post_id)
  end
end
