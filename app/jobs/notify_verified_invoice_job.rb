# frozen_string_literal: true

class NotifyVerifiedInvoiceJob < ApplicationJob
  queue_as :default

  def perform(payment)
    payment.send_invoice_verified_email
  end
end
