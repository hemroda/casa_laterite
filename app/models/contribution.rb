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

# ## Schema Information
#
# Table name: `contributions`
#
# ### Columns
#
# Name                      | Type               | Attributes
# ------------------------- | ------------------ | ---------------------------
# **`id`**                  | `bigint`           | `not null, primary key`
# **`amount`**              | `float`            | `default(0.0), not null`
# **`cancelled_by_type`**   | `string`           |
# **`contributable_type`**  | `string`           | `not null`
# **`contribution_type`**   | `integer`          |
# **`description`**         | `text`             |
# **`discarded_at`**        | `datetime`         |
# **`name`**                | `string`           | `not null`
# **`validated_by_type`**   | `string`           |
# **`created_at`**          | `datetime`         | `not null`
# **`updated_at`**          | `datetime`         | `not null`
# **`account_id`**          | `bigint`           |
# **`cancelled_by_id`**     | `bigint`           |
# **`contributable_id`**    | `bigint`           | `not null`
# **`validated_by_id`**     | `bigint`           |
#
# ### Indexes
#
# * `index_contributions_on_account_id`:
#     * **`account_id`**
# * `index_contributions_on_cancelled_by`:
#     * **`cancelled_by_type`**
#     * **`cancelled_by_id`**
# * `index_contributions_on_contributable`:
#     * **`contributable_type`**
#     * **`contributable_id`**
# * `index_contributions_on_discarded_at`:
#     * **`discarded_at`**
# * `index_contributions_on_validated_by`:
#     * **`validated_by_type`**
#     * **`validated_by_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`account_id => accounts.id`**
#
