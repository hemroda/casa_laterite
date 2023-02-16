# frozen_string_literal: true

class BackgroundJobsCheckJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    # Simulates a long, time-consuming task
    sleep 5

    user = User.find(user_id)
    SystemConfigMailer.with(user: {name: user.full_name_or_email, email: ENV["SES_SENDER_EMAIL"]}).background_jobs_health_check_email.deliver_later
  end
end
