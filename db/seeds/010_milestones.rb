# frozen_string_literal: true

if Milestone.count.zero?
  p "Seeding Milestones"

  Project.all.each do |project|
    project.milestones.create(name: Faker::Lorem.sentence(word_count: 3), status: 1)
    project.milestones.create(name: Faker::Lorem.sentence(word_count: 3))
    project.milestones.create(name: Faker::Lorem.sentence(word_count: 3))
  end
end
