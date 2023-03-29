# frozen_string_literal: true

class Campaign < ApplicationRecord
  enum status: %i[draft in_progress archived]
  enum access_type: %i[for_users for_accounts]

  has_many :questions, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank
end

# ## Schema Information
#
# Table name: `campaigns`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `bigint`           | `not null, primary key`
# **`access_type`**  | `integer`          | `default("for_users")`
# **`name`**         | `string`           | `not null`
# **`status`**       | `integer`          | `default("draft")`
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#
