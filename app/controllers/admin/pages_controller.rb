# frozen_string_literal: true

class Admin::PagesController < ApplicationController
  layout "admin"

  before_action :authenticate_user!

  def dashboard
  end

  def system
  end

  def check_background_jobs
    BackgroundJobsCheckJob.perform_later(current_user)

    redirect_to admin_system_path, notice: "Background Jobs Health check lunched! \n Check your emails!! 😉"
  end
end
