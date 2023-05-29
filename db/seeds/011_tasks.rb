# frozen_string_literal: true

if Task.count.zero?
  puts "Seeding Tasks"

  15.times do
    Task.create(
      name: Faker::Lorem.sentence(word_count: 3),
      description: Faker::Lorem.paragraphs,
      project_id: 1,
      milestone_id: Project.first.milestone_ids.sample,
    )
  end

  7.times do
    Task.create(
      name: Faker::Lorem.sentence(word_count: 3),
      user_id: 1,
      status: 1,
    )
  end
end
