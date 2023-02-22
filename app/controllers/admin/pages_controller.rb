# frozen_string_literal: true

class Admin::PagesController < ApplicationController
  layout "admin"

  before_action :authenticate_user!

  def dashboard
    @events = Event.for_user(current_user).undiscarded
    @posts = Post.users_posts.includes(:user).order(created_at: :desc)
    @personal_projects = Project.for_user_personal(current_user).tracked
    @corporate_projects = Project.includes([:milestones, :tasks]).tracked
  end

  def system
  end

  def check_background_jobs
    BackgroundJobsCheckJob.perform_later(current_user.id)

    redirect_to admin_system_path, notice: "Background Jobs Health check lunched! \n Check your emails!! 😉"
  end
end
