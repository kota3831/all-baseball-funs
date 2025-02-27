class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @posts = Post.page(params[:page]).per(5).order(created_at: :desc)
    @post = Post.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to my_page_path, alert: "他のユーザーの情報は編集できません"
    else
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Your accounte has been successfully cancell"
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to mypage_path
    end
  end

  def delete_account
    current_user.destroy
    redirect_to new_user_registration_path
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @users = User.search(params[:search])
  end
end
