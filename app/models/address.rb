# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :line_one, :city, :zip_code, :country, presence: true

  has_rich_text :additional_information
end

# ## Schema Information
#
# Table name: `addresses`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `bigint`           | `not null, primary key`
# **`additional_information`**  | `text`             |
# **`addressable_type`**        | `string`           |
# **`city`**                    | `string`           |
# **`country`**                 | `string`           |
# **`line_one`**                | `string`           |
# **`line_two`**                | `string`           |
# **`phone_number`**            | `string`           |
# **`zip_code`**                | `string`           |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
# **`addressable_id`**          | `bigint`           |
#
# ### Indexes
#
# * `index_addresses_on_addressable`:
#     * **`addressable_type`**
#     * **`addressable_id`**
#
