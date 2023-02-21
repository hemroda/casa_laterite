# frozen_string_literal: true

if ProjectType.count.zero?
  p "Seeding Project Types"

  10.times do |index|
    ProjectType.create(name: Faker::Construction.subcontract_category) if index.odd?
    ProjectType.create(name: Faker::Construction.heavy_equipment) if index.even?
  end

  10.times do
    ProjectType.create(name: Faker::Company.catch_phrase)
  end
end

