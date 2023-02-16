# frozen_string_literal: true

class SystemConfigMailer < ApplicationMailer
  default from: ENV["SES_SENDER_EMAIL"]

  def background_jobs_health_check_email
    @user = params[:user]
    mail(to: @user[:email], subject: 'Background jobs health check')
  end
end
