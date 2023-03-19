FactoryBot.define do
  factory :manager do
    
  end
end

# ## Schema Information
#
# Table name: `managers`
#
# ### Columns
#
# Name                      | Type               | Attributes
# ------------------------- | ------------------ | ---------------------------
# **`id`**                  | `bigint`           | `not null, primary key`
# **`assigned_by_type`**    | `string`           |
# **`lead_manager`**        | `boolean`          | `default(FALSE)`
# **`manageable_type`**     | `string`           | `not null`
# **`unassigned_by_type`**  | `string`           |
# **`created_at`**          | `datetime`         | `not null`
# **`updated_at`**          | `datetime`         | `not null`
# **`assigned_by_id`**      | `bigint`           |
# **`manageable_id`**       | `bigint`           | `not null`
# **`unassigned_by_id`**    | `bigint`           |
# **`user_id`**             | `bigint`           |
#
# ### Indexes
#
# * `index_managers_on_assigned_by`:
#     * **`assigned_by_type`**
#     * **`assigned_by_id`**
# * `index_managers_on_manageable`:
#     * **`manageable_type`**
#     * **`manageable_id`**
# * `index_managers_on_unassigned_by`:
#     * **`unassigned_by_type`**
#     * **`unassigned_by_id`**
# * `index_managers_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`user_id => users.id`**
#
