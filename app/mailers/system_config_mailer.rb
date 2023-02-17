# frozen_string_literal: true

class SystemConfigMailer < ApplicationMailer
  default from: "hemroda@gmail.com"

  def background_jobs_health_check_email
    @user = params[:user]
    mail(to: @user[:email], subject: 'Background jobs health check')
  end
end
