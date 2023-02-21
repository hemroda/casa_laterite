# frozen_string_literal: true

module Admin
  class ManagersController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_manager, only: %i[reassign_manager unassign_manager remove_as_lead set_as_lead]

    def create
      @manager = Manager.new(manager_params)
      @manager.assigned_by = current_user
      if @manager.save
        redirect_back fallback_location: @manageable, notice: "A new Manager has been assigned to the #{@manager.manageable_type}!"
      else
        redirect_back fallback_location: @manageable, alert: "The new Manager has NOT been assigned to the #{@manager.manageable_type}!"
      end
    end

    def reassign_manager
      if @manager.reassign_as_manager!(current_user)
        redirect_back fallback_location: @manager.manageable, notice: "Manager assigned to user!"
      end
    end

    def unassign_manager
      if @manager.unassign_as_manager!(current_user)
        redirect_back fallback_location: @manager.manageable, notice: "Manager assignment removed!"
      end
    end

    def remove_as_lead
      @manager.lead_manager = false
      if @manager.save
        redirect_back fallback_location: @manager.manageable, notice: "Manager unassigned as lead!"
      end
    end

    def set_as_lead
      @manager.lead_manager = true
      if @manager.save
        redirect_back fallback_location: @manager.manageable, notice: "Manager assigned as lead!"
      end
    end

    private

    def set_manager
      @manager = Manager.find(params[:id])
    end

    def manager_params
      params.require(:manager).permit(
        :id,
        :user_id,
        :assigned_by_id,
        :manageable_type,
        :manageable_id
      )
    end
  end
end
