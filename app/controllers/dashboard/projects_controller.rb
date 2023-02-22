# frozen_string_literal: true

class Dashboard::ProjectsController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_project, only: %i[show]
  before_action :authorized_account, only: %i[show]

  def show; end

  private
    def authorized_account
      unless current_account.project_ids.include?(@project.id)
        redirect_back fallback_location: dashboard_root_path, alert: I18n.t("dashboard.authorization.message")
      end
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
