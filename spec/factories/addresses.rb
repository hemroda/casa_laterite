FactoryBot.define do
  factory :address do
    
  end
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
