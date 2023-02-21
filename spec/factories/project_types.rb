# frozen_string_literal: true

FactoryBot.define do
  factory :project_type do
    name { Faker::Name }
  end
end
