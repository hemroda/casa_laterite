# frozen_string_literal: true

module Admin
  class CampaignsController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_campaign, only: %i[show edit update destroy]

    def index
      @q = Campaign.ransack(params[:q])
      @pagy, @campaigns = pagy(@q.result(distinct: true))
      @fields_to_search_in = :name_cont
    end

    def show; end

    def new
      @campaign = Campaign.new
    end

    def edit; end

    def create
      @campaign = Campaign.new(campaign_params)
      if @campaign.save
        redirect_to admin_campaign_path(@campaign), notice: "Campaign created!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @campaign.update(campaign_params)
        redirect_to admin_campaign_path(@campaign), notice: "The campaign has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @campaign.destroy
        redirect_to admin_campaigns_path, notice: "The campaign has been deleted."
      else
        redirect_to admin_campaigns_path, alert: "The campaign has NOT been deleted."
      end
    end

    private
      def set_campaign
        @campaign = Campaign.includes(:questions).find(params[:id])
      end

      def campaign_params
        params.require(:campaign).permit(
          :name,
          :access_type,
          :user_id,
          :status,
          questions_attributes: [
            :_destroy,
            :id,
            :body,
            { answers_attributes: %i[_destroy id body] }
          ])
      end
  end
end
