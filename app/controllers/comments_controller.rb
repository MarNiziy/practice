class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :load_user, :load_post

	def create
        @comment = current_user.comments.build(comment_params)
        @comment.post = @post
        	if @comment.save!
        		redirect_to user_post_path(@user, @post)
        	end
	end


    def destroy
        @comment = Comment.find(params[:id])
        @post = @comment.post
        
        @comment.destroy
        redirect_to user_post_path(@user, @post)
    end

	private

    def comment_params
      params.require(:comment).permit(:post, :content)
    end

    def load_user
        @user = User.find(params[:user_id])
    end

    def load_post
        @post = Post.find(params[:post_id])
    end

end

