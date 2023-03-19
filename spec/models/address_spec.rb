require 'rails_helper'

RSpec.describe Address, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
