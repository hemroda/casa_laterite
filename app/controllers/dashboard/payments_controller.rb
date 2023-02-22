# frozen_string_literal: true

class Dashboard::PaymentsController < ApplicationController
  layout "dashboard"

  before_action :authenticate_account!
  before_action :set_payment, only: %i[edit update]
  before_action :authorized_account, only: %i[edit update]

  def edit; end

  def update
    if @payment.update(payment_params) && @payment.pending_invoice_review!
      redirect_to dashboard_contribution_path(@payment.payable.id), notice: "The invoice was successfully uploaded."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def authorized_account
      redirect_back fallback_location: dashboard_root_path, alert: I18n.t("dashboard.authorization.message") unless current_account.payments.pluck(:id).include?(@payment.id)
    end

    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(
        :amount,
        :message,
        :name,
        :invoice,
        :status,
      )
    end
end
