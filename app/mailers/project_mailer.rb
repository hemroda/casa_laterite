# frozen_string_literal: true

class ProjectMailer < ApplicationMailer
  default from: "Laterite Team <no-reply@laterite.casa>"

  def invite_user_email(inviter, invited_user)
    @project = params[:project]
    @invited_user = invited_user
    @inviter = inviter

    mail(to: invited_user.email, subject: "You are invited to a project", project_name: @project.name)
  end

  def project_finished_email(user)
    @project = params[:project]

    mail(to: user.email, subject: "The project is finished", project_name: @project.name)
  end
end
