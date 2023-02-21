# frozen_string_literal: true

module Admin
  class TimersController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_timer, only: %i[edit update destroy stop]

    def new
      @timer = Timer.new(task_id: params[:task_id], start_at: Time.now)
      if @timer.save
        redirect_back fallback_location: admin_project_path(@timer.task.project), notice: "The timer is started."
      end
    end

    def edit; end

    def update
      if @timer.update(timer_params)
        redirect_back fallback_location: admin_task_path(@timer.task), notice: "The timer has been updated."
      else
        redirect_back fallback_location: admin_task_path(@timer.task), alert: "The timer has NOT been updated."
      end
    end

    def destroy
      if @timer.destroy
        redirect_to admin_timers_path, notice: "The timer has been deleted."
      else
        redirect_to admin_timers_path, alert: "The timer has NOT been deleted."
      end
    end

    def stop
      @timer.end_at = Time.now
      if @timer.save
        redirect_back fallback_location: admin_project_path(@timer.task.project), notice: "Timer has been stopped!"
      else
        redirect_back fallback_location: admin_project_path(@timer.task.project), alert: "Timer has NOT been stopped!"
      end
    end

    private
      def set_timer
        @timer = Timer.find(params[:id])
      end

      def timer_params
        params.require(:timer).permit(:id,
                                      :start_at,
                                      :end_at,
                                      :task_id)
      end
  end
end
