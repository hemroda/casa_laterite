# frozen_string_literal: true

class Payment < ApplicationRecord
  include Discard::Model

  enum status: %i[no_invoice pending_invoice_review payed]

  belongs_to :payable, polymorphic: true
  belongs_to :created_by, polymorphic: true
  belongs_to :canceled_by, polymorphic: true, optional: true
  belongs_to :validated_by, polymorphic: true, optional: true

  has_many :notifications, -> { order(created_at: :desc) }, as: :noticeable, dependent: :destroy, inverse_of: :noticeable

  has_one_attached :invoice

  has_rich_text :message

  validates :amount, presence: true

  def cancel_payment!(user)
    self.canceled_by = user
    discard
  end

  def validate_invoice!(user)
    return unless self.invoice.present?

    self.validated_by = user
    self.payed!
    save
  end

  def overdue_payment_reminder!(payment, notifier)
    return unless due_date.past?
    return if notifications.last.created_at.today? unless notifications.empty?

    NotifyOverduePaymentJob.perform_later(payment, notifier)
  end

  def send_invoice_verified_email
    PaymentMailer.with(payment: self).invoice_verified_email(self.payable).deliver_later
  end

  def send_overdue_remainder_email
    PaymentMailer.with(payment: self).overdue_remainder_email(self.payable).deliver_later
  end
end
