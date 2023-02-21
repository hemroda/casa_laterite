# frozen_string_literal: true

class Admin::ProjectsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy track un_track authorization_for_personal_project]
  before_action :authorization_for_personal_project, only: %i[show edit update destroy]

  def index
    @q = Project.corporate.includes(:project_type).ransack(params[:q])
    @pagy, @projects = pagy(@q.result(distinct: true))
    @fields_to_search_in = :name_cont
  end

  def show
    @milestones = @project.milestones.includes([:rich_text_description])
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_back fallback_location: admin_projects_path, notice: "Project was successfully created!"
    else
      redirect_back fallback_location: admin_projects_path, alert: "Project was NOT created!"
    end
  end

  def update
    if @project.update(project_params)
      redirect_to admin_project_path(@project), notice: "The project has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @project.destroy
      redirect_to admin_projects_path, notice: "The project has been deleted."
    else
      redirect_to admin_projects_path, alert: "The project has NOT been deleted."
    end
  end

  def track
    @project.tracked = true

    if @project.save
      redirect_to admin_project_path(@project), notice: "Project tracked! You should see it on your dashboard."
    else
      redirect_to admin_project_path(@project), alert: "Project un_tracked! Something went wrong."
    end
  end

  def un_track
    @project.tracked = false

    if @project.save
      redirect_to admin_project_path(@project), notice: "Project no longer pinned on dashboard!"
    else
      redirect_to admin_project_path(@project), alert: "Project still pinned on dashboard! Something went wrong."
    end
  end

  private
    def authorization_for_personal_project
      redirect_back fallback_location: admin_projects_path, alert: "No can do buddy. Private project^^" if @project.personal? && current_user.id != @project.projectable_id
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(
        :id,
        :visibility_type,
        :description,
        :name,
        :end_date,
        :project_type_id,
        :start_date,
        :status,
        :user_id,
        :tracked,
        :projectable_type,
        :projectable_id,
        documents: [],
        images: [],
        milestones_attributes: [
          :id,
          :_destroy,
          :description,
          :name,
          :end_date,
          :start_date,
          :project_id,
          { tasks_attributes: %i[
            id
            _destroy
            name
            description
            start_date
            end_date
            project_id
            milestone_id
          ] }
        ],
        tasks_attributes: %i[
          id
          _destroy
          description
          end_date
          name
          start_date
          project_id
        ])
    end
end
