# frozen_string_literal: true

class Admin::Projects::ManagersController < Admin::ManagersController
  private
    def set_manageable
      @manageable = Project.find(params[:project_id])
    end
end
