# frozen_string_literal: true

module Admin
  class PaymentsController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :set_payment, only: %i[edit update destroy validate_invoice overdue_payment_reminder]
    before_action :set_payable

    def index
      @q = Payment.includes(:payable).ransack(params[:q])
      @pagy, @payments = pagy(@q.result(distinct: true))
      @fields_to_search_in = :name_cont
    end

    def show; end

    def new
      @payment = Payment.new
    end

    def edit; end

    def create
      @payment = @payable.payments.build(payment_params)
      @payment.created_by_id = current_user.id
      @payment.created_by_type = "User"

      if @payment.save
        redirect_back fallback_location: @payable, notice: "Payment created"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @payment.update(payment_params)
        redirect_to admin_payment_path(@payment), notice: "The payment has been updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @payment = Payment.find(params[:id])

      if @payment.cancel_payment!(current_user)
        redirect_back fallback_location: @payable, notice: "Payment discarded"
      else
        redirect_back fallback_location: @payable, alert: "Payment NOT discarded"
      end
    end

    def validate_invoice
      if @payment.validate_invoice!(current_user)
        NotifyVerifiedInvoiceJob.perform_later(@payment)
        redirect_back fallback_location: @payable, notice: "Payment validated!"
      else
        redirect_back fallback_location: @payable, alert: "Payment NOT validated! Have you checked the invoice's presence?"
      end
    end

    def overdue_payment_reminder
      if @payment.overdue_payment_reminder!(@payment, current_user)
        redirect_back fallback_location: @payment.payable, notice: "Payment overdue reminder sent!"
      else
        redirect_back fallback_location: @payment.payable, alert: "Payment overdue reminder NOT sent! Maybe you already sent one today!?"
      end
    end

    private
      def set_payment
        @payment = Payment.find(params[:id])
      end

      # Empty method to prevent error, "undefined method `set_payable'", when on index page
      def set_payable; end

      def payment_params
        params.require(:payment).permit(
          :amount,
          :message,
          :name,
          :invoice,
          :status,
          :due_date,
        )
      end
  end
end
