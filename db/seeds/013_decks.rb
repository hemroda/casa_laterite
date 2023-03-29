if Campaign.count.zero?
  p "Seeding campaigns with questions and answers"

  # Campaign #1
  Campaign.create(
    name: "Movie quote",
    status: Campaign.statuses[:in_progress]
  )
  5.times do
    Question.create(
      body: Faker::Movie.quote,
      campaign_id: Campaign.last.id,
      answers: [
        Answer.create(body: Faker::Movie.title),
        Answer.create(body: Faker::Movie.title)
      ]
    )
  end

  # Campaign #2
  Campaign.create(
    name: "Famous last words",
    status: Campaign.statuses[:published],
    access_type: Campaign.access_types[:global],
  )
  5.times do
    Question.create(
      body: Faker::Quote.famous_last_words,
      campaign_id: Campaign.last.id,
      answers: [
        Answer.create(body: Faker::Artist.name),
        Answer.create(body: Faker::Artist.name)
      ]
    )
  end
end
