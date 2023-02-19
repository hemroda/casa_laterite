# frozen_string_literal: true

class Dashboard::PostsController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorized_users, only: %i[show edit update destroy]

  def index
    @posts = Post.accounts_posts.includes(:account).order(created_at: :desc)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to dashboard_posts_path
    else
      redirect_to dashboard_posts_path, alert: "Post not created!"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to dashboard_my_messages_path, notice: "The post has been updated."
    else
      # render :edit, status: :unprocessable_entity
      redirect_back fallback_location: dashboard_my_messages_path, alert: "The post has NOT been updated"
    end
  end

  def destroy
    if @post.destroy
      redirect_back fallback_location: dashboard_posts_path, notice: "Post deleted!"
    else
      redirect_back fallback_location: dashboard_posts_path, alert: "Post not deleted!"
    end
  end

  def my_posts
    @posts = current_account.posts
  end

  private
    def authorized_users
      redirect_back fallback_location: dashboard_root_path, alert: "No can do buddy." unless current_account.id == @post.account_id
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(
        :content, :account_id
      )
    end
end
