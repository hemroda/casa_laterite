# frozen_string_literal: true

class Admin::PagesController < ApplicationController
  layout "admin"

  def dashboard
  end

  def system
  end

  def check_background_jobs
    BackgroundJobsCheckJob.perform_later

    # TODO: update notification message when the emailing system is set.
    # Should tell user to check their email instead of system logs.
    redirect_to admin_system_path, notice: "Background Jobs Health check successful! 🥳 \n Check the logs!! 😉"
  end
end
