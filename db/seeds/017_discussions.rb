# frozen_string_literal: true

if Discussion.count.zero?
  p "Seeding Discussion with SharedDiscussion"

  3.times do |index|
    Discussion.create(
      subject: Faker::Lorem.sentence,
      discussable_type: index.odd? ? "Account" : "Property",
      discussable_id: 1,
      description: Faker::Lorem.paragraph(sentence_count: 4)
    )
  end

  3.times do |index|
    SharedDiscussion.create(discussion: Discussion.find(index + 1), invited_by: Account.first, account_id: Account.first.id)
  end
end
