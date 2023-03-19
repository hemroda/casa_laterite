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

# ## Schema Information
#
# Table name: `payments`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `bigint`           | `not null, primary key`
# **`amount`**             | `float`            | `default(0.0), not null`
# **`canceled_by_type`**   | `string`           |
# **`created_by_type`**    | `string`           | `not null`
# **`discarded_at`**       | `datetime`         |
# **`due_date`**           | `datetime`         |
# **`message`**            | `text`             |
# **`name`**               | `string`           | `not null`
# **`payable_type`**       | `string`           | `not null`
# **`status`**             | `integer`          | `default("no_invoice")`
# **`validated_by_type`**  | `string`           |
# **`created_at`**         | `datetime`         | `not null`
# **`updated_at`**         | `datetime`         | `not null`
# **`canceled_by_id`**     | `bigint`           |
# **`created_by_id`**      | `bigint`           | `not null`
# **`payable_id`**         | `bigint`           | `not null`
# **`validated_by_id`**    | `bigint`           |
#
# ### Indexes
#
# * `index_payments_on_canceled_by`:
#     * **`canceled_by_type`**
#     * **`canceled_by_id`**
# * `index_payments_on_created_by`:
#     * **`created_by_type`**
#     * **`created_by_id`**
# * `index_payments_on_discarded_at`:
#     * **`discarded_at`**
# * `index_payments_on_payable`:
#     * **`payable_type`**
#     * **`payable_id`**
# * `index_payments_on_validated_by`:
#     * **`validated_by_type`**
#     * **`validated_by_id`**
#
