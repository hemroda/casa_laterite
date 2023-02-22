if Deck.count.zero?
  p "Seeding Decks with questions and answers"

  # Deck #1
  Deck.create(
    name: "Movie quote",
    user_id: 1,
    status: Deck.statuses[:in_progress]
  )
  5.times do
    Question.create(
      body: Faker::Movie.quote,
      deck_id: Deck.last.id,
      answers: [
        Answer.create(body: Faker::Movie.title),
        Answer.create(body: Faker::Movie.title)
      ]
    )
  end

  # Deck #2
  Deck.create(
    name: "Famous last words",
    status: Deck.statuses[:published],
    access_type: Deck.access_types[:global],
    user_id: 1
  )
  5.times do
    Question.create(
      body: Faker::Quote.famous_last_words,
      deck_id: Deck.last.id,
      answers: [
        Answer.create(body: Faker::Artist.name),
        Answer.create(body: Faker::Artist.name)
      ]
    )
  end
end
