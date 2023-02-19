if Post.count.zero?
  p "Seeding Random Posts"
  50.times do |index|
    if index.odd?
      Post.create(
        content: Faker::Lorem.paragraph_by_chars(number: 246, supplemental: false),
        user_id: rand(1..13)
      )
    else
      Post.create(
        content: Faker::Lorem.paragraph_by_chars(number: 246, supplemental: false),
        account_id: rand(1..14)
      )
    end
  end
end
