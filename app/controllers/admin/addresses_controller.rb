# frozen_string_literal: true

class Admin::AddressesController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_address, only: %i[show edit update destroy]

  def show; end

  def new
    @address = Address.new
  end

  def edit; end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_back fallback_location: admin_properties_path, notice: "address was created!"
    else
      redirect_back fallback_location: admin_properties_path, alert: "Address was NOT created!"
    end
  end

  def update
    if @address.update(address_params)
      redirect_back fallback_location: admin_property_path(@address.addressable_id), notice: "The address has been updated."
    else
      redirect_back fallback_location: admin_properties_path, alert: "The address has NOT been updated."
    end
  end

  def destroy
    if @address.destroy
      redirect_back fallback_location: admin_properties_path, notice: "The address has been deleted."
    else
      redirect_back fallback_location: admin_properties_path, alert: "The address has NOT been deleted."
    end
  end

  private

    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(
        :line_one,
        :line_two,
        :city,
        :country,
        :zip_code,
        :phone_number,
        :additional_information,
        :addressable_type,
        :addressable_id,
      )
    end
end
