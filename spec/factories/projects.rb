# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Name }
    project_type { association(:project_type) }
    association :projectable, factory: :property
  end
end

# ## Schema Information
#
# Table name: `projects`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `bigint`           | `not null, primary key`
# **`completed_at`**      | `datetime`         |
# **`description`**       | `text`             |
# **`end_date`**          | `datetime`         |
# **`name`**              | `string`           |
# **`projectable_type`**  | `string`           | `not null`
# **`start_date`**        | `datetime`         |
# **`status`**            | `integer`          | `default("draft")`
# **`tracked`**           | `boolean`          | `default(FALSE)`
# **`visibility_type`**   | `integer`          | `default("corporate")`
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
# **`project_type_id`**   | `bigint`           | `not null`
# **`projectable_id`**    | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_projects_on_project_type_id`:
#     * **`project_type_id`**
# * `index_projects_on_projectable`:
#     * **`projectable_type`**
#     * **`projectable_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`project_type_id => project_types.id`**
#
