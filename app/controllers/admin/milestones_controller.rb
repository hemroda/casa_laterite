# frozen_string_literal: true

class Admin::MilestonesController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_milestone, only: %i[show edit update destroy complete reactivate archive start]

  def index
    @milestones = Milestone.all
  end

  def show; end

  def new
    @milestone = Milestone.new
  end

  def edit; end

  def create
    @milestone = Milestone.new(milestone_params)

    if @milestone.save
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "Milestone was created!"
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "Milestone was not created!"
    end
  end

  def update
    if @milestone.update(milestone_params)
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "The milestone has been updated."
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "The milestone has NOT been updated."
    end
  end

  def destroy
    if @milestone.destroy
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "The milestone has been deleted."
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "The milestone has NOT been deleted."
    end
  end

  def start
    if @milestone.start!
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "The milestone was set to in progress!"
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "The milestone was not set to in progress!"
    end
  end

  def complete
    if @milestone.completed!
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "The milestone was set to completed!"
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "The milestone was not set to completed!"
    end
  end

  def reactivate
    if @milestone.in_progress!
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "The milestone was set to reactivated!"
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "The milestone was not set to reactivated!"
    end
  end

  def archive
    if @milestone.archived!
      redirect_back fallback_location: admin_project_path(@milestone.project), notice: "The milestone was set to archived!"
    else
      redirect_back fallback_location: admin_project_path(@milestone.project), alert: "The milestone was not set to archived!"
    end
  end

  private
    def set_milestone
      @milestone = Milestone.find(params[:id])
    end

    def milestone_params
      params.require(:milestone).permit(:name, :description, :end_date, :start_date, :project_id, :status)
    end
end
