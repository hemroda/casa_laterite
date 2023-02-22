# frozen_string_literal: true

class Dashboard::AddressesController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_address, only: %i[show edit update destroy]

  def show; end

  def new
    @address = Address.new
  end

  def edit; end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to dashboard_account_path(current_account), notice: "L'adresse a été créée!"
    else
      redirect_to dashboard_account_path(current_account), notice: "L'adresse n'a pas été créée!"
    end
  end

  def update
    if @address.update(address_params)
      redirect_back fallback_location: dashboard_account_path(current_account), notice: "L'adresse a été mise à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @address.destroy
      redirect_to dashboard_account_path(current_account), notice: "The address has been deleted."
    else
      redirect_to dashboard_account_path(current_account), alert: "The address has NOT been deleted."
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:street_number, :street_name, :floor, :door, :building, :department, :city, :country,
                                      :zip_code, :phone_number, :additional_information, :latitude, :longitude,
                                      :addressable_id, :addressable_type
      )
    end
end
