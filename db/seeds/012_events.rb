if Event.count.zero?
  p "Seeding Events For First User"
  10.times do
    Event.create(
      user_id: 1,
      title: Faker::Restaurant.name,
      color: Faker::Color.hex_color,
      location: Faker::Address.street_address,
      start_time: Faker::Date.between(from: 5.days.ago, to: 15.days.from_now),
      description: Faker::Restaurant.description
    )
  end
  p "Seeding Events For Second User"
  1.times do
    Event.create(
      user_id: 2,
      title: "User #2's event",
      color: Faker::Color.hex_color,
      location: Faker::Address.street_address,
      start_time: Faker::Date.between(from: 5.days.ago, to: 15.days.from_now),
      description: Faker::Restaurant.description
    )
  end
end
