# frozen_string_literal: true

FactoryBot.define do
  factory :property_type do
    name { Faker::Name }
  end
end
