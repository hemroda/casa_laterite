# frozen_string_literal: true

FactoryBot.define do
  factory :project_type do
    name { Faker::Name }
  end
end

# ## Schema Information
#
# Table name: `project_types`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `bigint`           | `not null, primary key`
# **`name`**        | `string`           | `not null`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
