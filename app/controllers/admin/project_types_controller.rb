# frozen_string_literal: true

module Admin
  class ProjectTypesController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_project, only: %i[show edit update destroy]

    def index
      @q = ProjectType.all.ransack(params[:q])
      @pagy, @project_types = pagy(@q.result(distinct: true))
      @fields_to_search_in = :name_cont
    end

    def show; end

    def new
      @project_type = ProjectType.new
    end

    def edit; end

    def create
      @project_type = ProjectType.new(project_type_params)
      if @project_type.save
        redirect_to admin_project_type_path(@project_type), notice: "Project Type created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @project_type.update(project_type_params)
        redirect_to admin_project_type_path(@project_type), notice: "The project type has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @project_type.destroy
        redirect_to admin_project_types_path, notice: "The project type has been deleted."
      else
        redirect_to admin_project_types_path, alert: "The project type has NOT been deleted."
      end
    end

    private
      def set_project
        @project_type = ProjectType.find(params[:id])
      end

      def project_type_params
        params.require(:project_type).permit(:name)
      end
  end
end
