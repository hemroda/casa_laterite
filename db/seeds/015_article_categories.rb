if ArticleCategory.count.zero?
  p "Seeding Article Categories"
  categories = [
    "Backend",
    "Frontend",
    "DevOps",
    "DevOpsSec",
    "Product Management",
    "Scrum",
    "Best Practices",
    "Carrier",
    "Agile",
    "Project Management",
    "Business",
    "Tools",
    "System",
    "Linux"
  ]
  categories.each { |c| ArticleCategory.create(name: c) }
end
