# frozen_string_literal: true

module Admin
  class PropertyTypesController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_property, only: %i[show edit update destroy]

    def index
      @q = PropertyType.all.ransack(params[:q])
      @pagy, @property_types = pagy(@q.result(distinct: true))
      @fields_to_search_in = :name_cont
    end

    def show; end

    def new
      @property_type = PropertyType.new
    end

    def edit; end

    def create
      @property_type = PropertyType.new(property_type_params)
      if @property_type.save
        redirect_to admin_property_type_path(@property_type), notice: "property Type created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @property_type.update(property_type_params)
        redirect_to admin_property_type_path(@property_type), notice: "The property type has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @property_type.destroy
        redirect_to admin_property_types_path, notice: "The property type has been deleted."
      else
        redirect_to admin_property_types_path, alert: "The property type has NOT been deleted."
      end
    end

    private
      def set_property
        @property_type = PropertyType.find(params[:id])
      end

      def property_type_params
        params.require(:property_type).permit(:name)
      end
  end
end
