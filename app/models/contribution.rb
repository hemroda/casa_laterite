# frozen_string_literal: true

class Contribution < ApplicationRecord
  include Discard::Model

  enum contribution_type: %i[financial voluntary]

  belongs_to :account
  belongs_to :contributable, polymorphic: true, optional: false
  belongs_to :validated_by, polymorphic: true, optional: true
  belongs_to :cancelled_by, polymorphic: true, optional: true

  has_many :payments, -> { order(created_at: :desc) }, as: :payable, dependent: :destroy, inverse_of: :payable

  has_many_attached :documents

  has_rich_text :description

  validates :name, :contribution_type, presence: true

  scope :for_account, ->(account) { where("account_id = ?", account.id) }

  def amount_or_total_payments
    (amount.nil? || amount.presence.zero?) ? payments.sum(:amount) : amount
  end

  def unpaid_payments
    @unpaid_payments ||= payments.where(status: [:no_invoice, :pending_invoice_review])
  end

  def validate!(user)
    self.validated_by = user
    save
  end

  def cancel!(user)
    self.validated_by = nil
    self.cancelled_by = user
    save
  end
end
