if Article.count.zero?
  puts "Seeding Articles"
  10.times do |index|
    Article.create(
      title: "Article ##{index}",
      user_id: rand(1..20),
      article_category_ids: [rand(6..13)],
      content: Faker::Markdown.sandwich(sentences: 6, repeat: 3)
    )
  end

  Article.all.each do |a|
    a.update_columns(status: Article.statuses[:published], published_at: Date.today - rand(10_000)) if a.id.even?
  end
end
