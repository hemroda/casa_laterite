# frozen_string_literal: true

class Admin::PostsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorized_users, only: %i[show edit update destroy]

  def index
    @posts = Post.users_posts.includes(:user)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_root_path, notice: "Post posted -_-"
    else
      redirect_to admin_root_path, alert: "Post NOT posted -_-"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_my_posts_path, notice: "The post has been updated."
    else
      # render :edit, status: :unprocessable_entity
      redirect_back fallback_location: admin_my_posts_path, alert: "The post has NOT been updated"
    end
  end

  def destroy
    if @post.destroy
      redirect_back fallback_location: admin_root_path, notice: "Post deleted!"
    else
      redirect_back fallback_location: admin_root_path, alert: "Post NOT deleted!"
    end
  end

  def my_posts
    @posts = current_user.posts
  end

  private
    def authorized_users
      redirect_back fallback_location: admin_root_path, alert: "No can do buddy." unless current_user.id == @post.user_id
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(
        :content, :user_id
      )
    end
end
