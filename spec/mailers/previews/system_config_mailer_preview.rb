# frozen_string_literal: true

# Preview all emails at http://localhost:7000/rails/mailers/project
class SystemConfigMailerPreview < ActionMailer::Preview
  def background_jobs_health_check_email
    SystemConfigMailer.with(user: {name: User.first.full_name_or_email, email: User.first.email})
                      .background_jobs_health_check_email
  end
end
