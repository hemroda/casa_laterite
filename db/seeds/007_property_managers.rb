# frozen_string_literal: true

puts "Seeding Property Managers"

Property.all.each do |property|
  Manager.create(manageable_type: "Property", manageable_id: property.id, user_id: rand(1..16), lead_manager: true,
                 assigned_by: User.first)
  if property.id.odd?
    Manager.create(manageable_type: "Property", manageable_id: property.id, user_id: rand(1..16), lead_manager: true,
                   assigned_by: User.find(rand(1..16)))
  end
end
