# frozen_string_literal: true

class Dashboard::PropertiesController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_property, only: %i[show investment_opportunity]
  before_action :authorized_account, only: %i[show]

  def index
    @properties = current_account.properties.includes(:property_type, :photo_attachment, :rich_text_description)
  end

  def show; end

  def investment_opportunity; end

  private
    def authorized_account
      redirect_back fallback_location: dashboard_root_path, alert: "You are not allow to do that." unless current_account.properties.pluck(:id).include?(@property.id)
    end

    def set_property
      @property = Property.find(params[:id])
    end
end
