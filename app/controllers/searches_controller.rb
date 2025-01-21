class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      # @post = Post.find(params[:id])
      # @user = @post.user
    else
      @posts = Post.looks(params[:search], params[:word])
      # @post = Post.find(params[:id])
      # @user = @post.user
    end
  end
end