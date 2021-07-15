class PostsController < ApplicationController
	before_action :authenticate_user! 
  before_action :load_user, only: [:show, :index]
  #only: [:new, :create, :edit, :update, :destroy]
  
	def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(current_user, @post), flash: { success: "Post was added" }
    else
      render :new, flash: { alert: "Some error occured" }
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    redirect_to user_post_path, flash: { success: "Post was updated" }
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to action: :index
  end

  private

  def post_params
      params.require(:post).permit(:title, :body, :image)
    end
   
  def load_user
    @user = User.find(params[:user_id])
  end

end
