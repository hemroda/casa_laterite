# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    name { Faker::Name }
    project_type { association(:project_type) }
    association :projectable, factory: :property
  end
end
