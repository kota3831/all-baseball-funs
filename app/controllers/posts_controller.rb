class PostsController < ApplicationController
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.valid?
      if @post.update(post_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to post_path
      else
        render :edit
      end
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
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end

end