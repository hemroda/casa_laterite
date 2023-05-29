# frozen_string_literal: true


if Ownership.count.zero?
  puts "Seeding Owner"

  Property.all.each do |property|
    Ownership.create(account_id: rand(1..16), property_id: property.id, allocated_by: User.first)

    Ownership.create(account_id: rand(1..16), property_id: property.id, allocated_by: User.find(rand(2..16))) if property.id.odd?
  end
end
