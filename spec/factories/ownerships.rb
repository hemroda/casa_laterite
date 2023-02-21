# frozen_string_literal: true

FactoryBot.define do
  factory :ownership do
    account { association(:account) }
    property { association(:property) }
  end
end
