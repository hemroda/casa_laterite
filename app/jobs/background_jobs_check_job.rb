# frozen_string_literal: true

class BackgroundJobsCheckJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Simulates a long, time-consuming task
    sleep 5

    SystemConfigMailer.with(user: {name: user.full_name_or_email, email: user.email}).background_jobs_health_check_email.deliver_later
  end
end
