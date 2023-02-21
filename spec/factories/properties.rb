# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    name { Faker::Name }
    headline { Faker::Lorem.sentence }
    property_type { association(:property_type) }
  end
end
