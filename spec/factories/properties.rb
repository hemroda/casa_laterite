# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    name { Faker::Name }
    headline { Faker::Lorem.sentence }
    property_type { association(:property_type) }
  end
end

# ## Schema Information
#
# Table name: `properties`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `bigint`           | `not null, primary key`
# **`bathrooms`**         | `integer`          |
# **`description`**       | `text`             |
# **`headline`**          | `string`           |
# **`name`**              | `string`           | `not null`
# **`price`**             | `float`            |
# **`rooms`**             | `integer`          |
# **`square_feet`**       | `integer`          |
# **`year_built`**        | `datetime`         |
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
# **`building_id`**       | `bigint`           |
# **`property_type_id`**  | `bigint`           | `not null`
#
# ### Indexes
#
# * `index_properties_on_building_id`:
#     * **`building_id`**
# * `index_properties_on_property_type_id`:
#     * **`property_type_id`**
#
# ### Foreign Keys
#
# * `fk_rails_...`:
#     * **`building_id => properties.id`**
# * `fk_rails_...`:
#     * **`property_type_id => property_types.id`**
#
