# frozen_string_literal: true

class Dashboard::ContributionsController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_contribution, only: %i[ show ]
  before_action :authorized_account, only: %i[ show ]

  def index
    @q = Contribution.for_account(current_account).includes(:payments).ransack(params[:q])
    @pagy, @contributions = pagy(@q.result(distinct: true))
    @fields_to_search_in = :name_cont
  end

  def show
    @payable = @contribution
    @payment = Payment.new
    @payments = @contribution.payments
  end

  private
    def authorized_account
      redirect_back fallback_location: dashboard_root_path, alert: I18n.t("dashboard.authorization.message") unless current_account.contributions.pluck(:id).include?(@contribution.id)
    end

    def set_contribution
      @contribution = Contribution.find(params[:id])
    end
end
