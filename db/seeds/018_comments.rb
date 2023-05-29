# frozen_string_literal: true

if Comment.count.zero?
  puts "Seeding Comments for Discussions"

  Discussion.all.each do |p|
    4.times { |index| p.comments.create(content: Faker::Lorem.paragraph, submitted_by: (index.odd? ? User.first : Account.first)) }
    p.comments.each_with_index { |comment, index| rand(1..4).times { comment.comments.create(content: Faker::Lorem.paragraph, submitted_by: (index.odd? ? User.first : Account.first)) } if comment.id.even? }
  end
end
