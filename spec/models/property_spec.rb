# frozen_string_literal: true

require "rails_helper"

RSpec.describe Property, type: :model do
  let(:property) { create(:property, name: "Villa Marron") }
  let(:user) { create(:user, first_name: "john", last_name: "smith") }

  it "is valid with valid attributes" do
    expect(property).to be_valid
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
