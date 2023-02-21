# frozen_string_literal: true

class NotifyFinishedProjectJob < ApplicationJob
  queue_as :default

  def perform(id)
    project = Project.find(id)
    project.send_project_finished_email
  end
end
