# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/project
class ProjectMailerPreview < ActionMailer::Preview
  def invite_user_email
    ProjectMailer.with(project: Project.first).invite_user_email(User.first, User.last)
  end

  def project_finished_email
    ProjectMailer.with(project: Project.first).project_finished_email(User.first)
  end
end
