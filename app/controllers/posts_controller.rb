class PostsController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:show, :new, :edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @users = User.all
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created book successfully."
      redirect_to post_path(@post.id)
    else
      @user = current_user
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to post_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def is_matching_login_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to posts_path
    end
  end

  def redirect_if_not_logged_in
    redirect_to  new_user_session_path unless current_user
  end

end