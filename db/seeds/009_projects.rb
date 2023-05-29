# frozen_string_literal: true

if Project.count.zero?
  puts "Seeding Projects"

  puts "Seeding First Project"
  Project.create(
    name: "Real Estate Market Analysis",
    description: Faker::TvShows::SiliconValley.quote,
    project_type: ProjectType.find(rand(10..15)),
    status: 0,
    visibility_type: 1,
    start_date: Time.at(rand * Time.now.to_i),
    end_date: Time.at(rand(1..1.1) * Time.now.to_i),
    tracked: true,
    projectable: Property.first,
  )

  Project.create(
    name: "Software Development",
    description: Faker::TvShows::SiliconValley.quote,
    project_type: ProjectType.find(rand(10..15)),
    status: 0,
    visibility_type: 1,
    start_date: Time.at(rand * Time.now.to_i),
    end_date: Time.at(rand(1..1.1) * Time.now.to_i),
    tracked: true,
    projectable: User.first,
    )

  puts "Seeding Random Projects"
  20.times do |index|
    Project.create(
      name: Faker::TvShows::SiliconValley.invention,
      description: Faker::TvShows::SiliconValley.quote,
      project_type: ProjectType.find(rand(1..9)),
      status: 0,
      start_date: Time.at(rand * Time.now.to_i),
      end_date: Time.at(rand(1..1.1) * Time.now.to_i),
      tracked: false,
      projectable: Property.find(rand(1..10)),
      )
  end
end
