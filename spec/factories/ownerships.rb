# frozen_string_literal: true

FactoryBot.define do
  factory :ownership do
    account { association(:account) }
    property { association(:property) }
  end
end

# ## Schema Information
#
# Table name: `ownerships`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `bigint`           | `not null, primary key`
# **`allocated_by_type`**    | `string`           |
# **`deallocated_by_type`**  | `string`           |
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
# **`account_id`**           | `bigint`           |
# **`allocated_by_id`**      | `bigint`           |
# **`deallocated_by_id`**    | `bigint`           |
# **`old_owner_id`**         | `integer`          |
# **`property_id`**          | `bigint`           |
#
# ### Indexes
#
# * `index_ownerships_on_account_id`:
#     * **`account_id`**
# * `index_ownerships_on_allocated_by`:
#     * **`allocated_by_type`**
#     * **`allocated_by_id`**
# * `index_ownerships_on_deallocated_by`:
#     * **`deallocated_by_type`**
#     * **`deallocated_by_id`**
# * `index_ownerships_on_property_id`:
#     * **`property_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`account_id => accounts.id`**
# * `fk_rails_...`:
#     * **`property_id => properties.id`**
#
