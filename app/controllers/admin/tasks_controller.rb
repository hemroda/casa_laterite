# frozen_string_literal: true

module Admin
  class TasksController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_task, only: %i[show edit update destroy not_started start complete reactivate archive]

    def index
      @tasks = Task.all
    end

    def show
      @timers = @task.timers.order(:start_at)
    end

    def new
      @task = Task.new
    end

    def edit; end

    def create
      @task = Task.new(task_params)
      if @task.save
        if @task.project
          redirect_back fallback_location: admin_project_path(@task.project.id), notice: "Task has been created!"
        else
          redirect_back fallback_location: admin_root_path, notice: "Task has been created!"
        end
      else
        if @task.project
          redirect_back fallback_location: admin_project_path(@task.project.id), alert: "Task was not created! #{@task.errors.full_messages.to_sentence.capitalize}"
        else
          redirect_back fallback_location: admin_root_path, alert: "Task was not created! #{@task.errors.full_messages.to_sentence.capitalize}"
        end
      end
    end

    def update
      if @task.update(task_params)
        if @task.project
          redirect_back fallback_location: admin_project_path(@task.project.id), notice: "The task has been updated."
        else
          redirect_back fallback_location: admin_root_path, notice: "The task has been updated."
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @task.destroy
        if @task.project
          redirect_back fallback_location: admin_project_path(@task.project.id), notice: "The task has been deleted."
        else
          redirect_back fallback_location: admin_root_path, notice: "The task has been deleted."
        end
      else
        if @task.project
          redirect_back fallback_location: admin_project_path(@task.project.id), alert: "The task has NOT been deleted."
        else
          redirect_back fallback_location: admin_root_path, notice: "The task has NOT been deleted."
        end
      end
    end

    def not_started
      @task.not_started!
      @task.start_date = nil
      if @task.save
        redirect_back fallback_location: admin_project_path(@task.project), notice: "The task was set to not started!"
      else
        redirect_back fallback_location: admin_project_path(@task.project), alert: "The task was not set to not started!"
      end
    end

    def start
      @task.in_progress!
      @task.start_date = DateTime.now
      if @task.save
        redirect_back fallback_location: admin_project_path(@task.project), notice: "The task was set to in progress!"
      else
        redirect_back fallback_location: admin_project_path(@task.project), alert: "The task was not set to in progress!"
      end
    end

    def complete
      if @task.set_as_complete!
        redirect_back fallback_location: admin_root_path, notice: "The task was set to completed!"
      else
        redirect_back fallback_location: admin_root_path, alert: "The task was not set to completed. Have you completed all the todo items!"
      end
    end

    def reactivate
      if @task.reactivate!
        redirect_back fallback_location: admin_root_path, notice: "The task was reactivated!"
      else
        redirect_back fallback_location: admin_root_path, alert: "The task was not set to reactivated!"
      end
    end

    def archive
      if @task.archived!
        redirect_back fallback_location: admin_root_path, notice: "The task was set to archived!"
      else
        redirect_back fallback_location: admin_root_path, alert: "The task was not set to archived!"
      end
    end

    private
      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(
          :id,
          :name,
          :description,
          :status,
          :start_date,
          :end_date,
          :completed_at,
          :milestone_id,
          :project_id,
          :user_id,
          todo_items_attributes: %i[id _destroy title completed completed_at title],
        )
      end
  end
end
