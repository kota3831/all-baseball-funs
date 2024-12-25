class PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      redirect_to post_path(@post)
    else
      #flash[:error] = comment.errors.full_messages.join(", ")
      #redirect_to post_path(post)
      # @user = @post.user
      redirect_to post_path(@post), flash: { error: @post_comment.errors.full_messages }
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
