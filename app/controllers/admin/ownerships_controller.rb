# frozen_string_literal: true

class Admin::OwnershipsController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :set_ownership, only: %i[reallocate_account_to_property deallocate_account_from_property]

  def create
    @ownership = Ownership.new(ownership_params)
    @ownership.allocated_by = current_user
    @ownership.deallocated_by = nil

    if @ownership.save
      redirect_back fallback_location: admin_property_path(@ownership.property_id), notice: "A new Owner has been added to the Property!"
    else
      redirect_back fallback_location: admin_property_path(@ownership.property_id), alert: "#{@ownership.errors.full_messages.to_sentence.capitalize}"
    end
  end

  def reallocate_account_to_property
    if @ownership.reallocate_account_to_property!(current_user)
      redirect_back fallback_location: admin_property_path(@ownership.property_id), notice: "Account has been add as owner to property!"
    end
  end

  def deallocate_account_from_property
    if @ownership.deallocate_account_from_property!(current_user)
      redirect_back fallback_location: admin_property_path(@ownership.property_id), notice: "Account removed from owners list of this property!"
    end
  end

  private
    def set_ownership
      @ownership = Ownership.find(params[:id])
    end

    def ownership_params
      params.require(:ownership).permit(
        :property_id, :account_id
      )
    end
end
