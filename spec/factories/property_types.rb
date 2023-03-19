# frozen_string_literal: true

FactoryBot.define do
  factory :property_type do
    name { Faker::Name }
  end
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
