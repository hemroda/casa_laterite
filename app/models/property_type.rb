# frozen_string_literal: true

class PropertyType < ApplicationRecord
  has_many :properties

  validates :name, presence: true
end

# ## Schema Information
#
# Table name: `property_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`name`**        | `string`           |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
