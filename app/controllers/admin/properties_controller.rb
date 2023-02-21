# frozen_string_literal: true

module Admin
  class PropertiesController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_property, only: %i[show edit update destroy delete_photo]

    def index
      @q = Property.includes(:property_type).ransack(params[:q])
      @pagy, @properties = pagy(@q.result(distinct: true))
      @fields_to_search_in = :name_cont
    end

    def show
      @owners = @property.ownerships.includes([:account, :allocated_by, :deallocated_by])
      @property_managers = @property.managers.includes([:user, :assigned_by])
    end

    def new
      @property = Property.new
    end

    def create
      @property = Property.new(property_params)
      if @property.save
        redirect_to admin_property_path(@property), notice: "New property created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @property.update(property_params)
        redirect_to admin_property_path(@property.id), notice: "The property has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @property = Property.find(params[:id])
      if @property.destroy
        redirect_to admin_properties_path, notice: "The Property has been deleted"
      else
        redirect_back fallback_location: @property, alert: "Property NOT deleted"
      end
    end

    private
      def set_property
        @property = Property.find(params[:id])
      end

      def property_params
        params.require(:property).permit(
          :id,
          :description,
          :headline,
          :name,
          :rooms,
          :bathrooms,
          :price,
          :year_built,
          :property_type_id,
          :square_feet,
          :photo,
          :address,
          photos: [],
          documents: [],
        )
      end
  end
end
