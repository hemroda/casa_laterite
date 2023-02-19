# frozen_string_literal: true

if Property.count.zero?

  image_path = "#{Rails.root}/db/fixtures/images"

  # LAND
  # ------------------------
  # land 1
  p "Seeding Properties - land"

  land = Property.create(
    property_type: PropertyType.first,
    headline: Faker::Lorem.sentence,
    name: "Ambohibao-morondava",
    price: "120000000",
    square_feet: rand(100..1000),
    description: Faker::Lorem.sentence(word_count: 4),
  )
  land.photo.attach(io: File.open("#{image_path}/land/land_1/land_1_1.jpg"), filename: "land_1_1")
  photos = []
  Dir["#{Rails.root}/db/fixtures/images/land/land_1/photos/*"].each do |fname|
    photos << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  land.update(photos: photos)
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  land.update(documents: documents)


  # FARM
  # ------------------------
  # farm 1
  p "Seeding Properties - farm #1"

  farm = Property.create(
    property_type: PropertyType.first,
    headline: Faker::Lorem.sentence,
    name: "Ferme autonome",
    price: "20000000",
    square_feet: rand(100..1000),
    description: Faker::Lorem.sentence(word_count: 14),
    )
  farm.photo.attach(io: File.open("#{image_path}/farm/farm_1/farm_1_1.jpg"), filename: "farm_1_1")

  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  farm.update(documents: documents)


  # VILLAS
  # ------------------------
  # villa 1
  villa = Property.create(
    property_type: PropertyType.find(17),
    headline: Faker::Lorem.sentence,
    name: "Hortencia",
    rooms: 4,
    bathrooms: 2,
    square_feet: rand(100..1000),
    price: "120000000",
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
  )
  villa.photo.attach(io: File.open("#{image_path}/villas/villa_1/villa_1_1.jpg"), filename: "villa_1_1")
  photos = []
  Dir["#{Rails.root}/db/fixtures/images/villas/villa_1/photos/*"].each do |fname|
    photos << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  villa.update(photos: photos)
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  villa.update(documents: documents)

  # HOUSES
  # ------------------------
  # house 1
  house = Property.create(
    property_type: PropertyType.find(17),
    headline: Faker::Lorem.sentence,
    name: "Ankazo anosiala",
    rooms: 3,
    bathrooms: 1,
    square_feet: rand(100..1000),
    price: "1200000000",
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
  )
  house.photo.attach(io: File.open("#{image_path}/houses/house_1/house_1_1.jpg"), filename: "house_1_1")
  photos = []
  Dir["#{Rails.root}/db/fixtures/images/houses/house_1/photos/*"].each do |fname|
    photos << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  house.update(photos: photos)
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  house.update(documents: documents)


  # APARTMENTS
  # ------------------------
  p "Seeding Properties - apartments"

  # flat 1
  flat = Property.create(
    property_type: PropertyType.find(16),
    headline: Faker::Lorem.sentence,
    name: "Ambatoroka Ambany T4",
    rooms: 1,
    bathrooms: 1,
    square_feet: rand(100..1000),
    price: 800000.00,
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
    photos: [
      {io: File.open("#{image_path}/flats/flat_1_2.jpg"), filename: "flat_1_2.jpg"},
      {io: File.open("#{image_path}/flats/flat_1_3.jpg"), filename: "flat_1_3.jpg"}
    ]
  )
  flat.photo.attach(io: File.open("#{image_path}/flats/flat_1_1.jpg"), filename: "flat_1_1")
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  flat.update(documents: documents)

  # flat 2
  flat = Property.create(
    property_type: PropertyType.find(16),
    headline: Faker::Lorem.sentence,
    name: "Ivandry",
    rooms: 3,
    bathrooms: 1,
    square_feet: rand(100..1000),
    price: 2500000.00,
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
    photos: [
      {io: File.open("#{image_path}/flats/flat_2_2.jpg"), filename: "flat_2_2.jpg"},
      {io: File.open("#{image_path}/flats/flat_2_3.jpg"), filename: "flat_2_3.jpg"},
      {io: File.open("#{image_path}/flats/flat_2_4.jpg"), filename: "flat_2_4.jpg"},
      {io: File.open("#{image_path}/flats/flat_2_5.jpg"), filename: "flat_2_5.jpg"}
    ]
  )
  flat.photo.attach(io: File.open("#{image_path}/flats/flat_2_1.jpg"), filename: "flat_2_1")
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  flat.update(documents: documents)

  # flat 3
  flat = Property.create(
    property_type: PropertyType.find(16),
    headline: Faker::Lorem.sentence,
    name: "Mazoarivo",
    rooms: 3,
    bathrooms: 1,
    square_feet: rand(100..1000),
    price: 16000.00,
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
    photos: [
      {io: File.open("#{image_path}/flats/flat_3_2.jpg"), filename: "flat_3_2.jpg"},
      {io: File.open("#{image_path}/flats/flat_3_3.jpg"), filename: "flat_3_3.jpg"},
      {io: File.open("#{image_path}/flats/flat_3_4.jpg"), filename: "flat_3_4.jpg"},
      {io: File.open("#{image_path}/flats/flat_3_5.jpg"), filename: "flat_3_5.jpg"}
    ]
  )
  flat.photo.attach(io: File.open("#{image_path}/flats/flat_3_1.jpg"), filename: "flat_3_1")
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  flat.update(documents: documents)

  # flat 4
  flat = Property.create(
    property_type: PropertyType.find(16),
    headline: Faker::Lorem.sentence,
    name: "Behoririka",
    rooms: 3,
    bathrooms: 1,
    square_feet: rand(100..1000),
    price: 25000000.00,
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
    photos: [
      {io: File.open("#{image_path}/flats/flat_4_2.jpg"), filename: "flat_4_2.jpg"},
      {io: File.open("#{image_path}/flats/flat_4_3.jpg"), filename: "flat_4_3.jpg"},
      {io: File.open("#{image_path}/flats/flat_4_4.jpg"), filename: "flat_4_4.jpg"},
      {io: File.open("#{image_path}/flats/flat_4_5.jpg"), filename: "flat_4_5.jpg"},
      {io: File.open("#{image_path}/flats/flat_4_6.jpg"), filename: "flat_4_6.jpg"}
    ]
  )
  flat.photo.attach(io: File.open("#{image_path}/flats/flat_4_1.jpg"), filename: "flat_4_1")
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  flat.update(documents: documents)

  # STUDIO
  # ------------------------
  # studio 1
  flat = Property.create(
    property_type: PropertyType.find(16),
    headline: Faker::Lorem.sentence,
    name: "Ambatoroka Ambany",
    rooms: 1,
    bathrooms: 1,
    square_feet: rand(100..1000),
    price: 1200000.90,
    year_built: Time.at(rand * Time.now.to_i),
    description: Faker::Lorem.sentence(word_count: 14),
  )
  flat.photo.attach(io: File.open("#{image_path}/studios/studio_1/studio_1_1.jpg"), filename: "studio_1_1")
  photos = []
  Dir["#{Rails.root}/db/fixtures/images/studios/studio_1/photos/*"].each do |fname|
    photos << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  flat.update(photos: photos)
  documents = []
  Dir["#{Rails.root}/db/fixtures/files/property/*"].each do |fname|
    documents << {io: File.open(fname), filename: (File.basename fname).to_s}
  end
  flat.update(documents: documents)

  # RANDOM PROPERTIES
  # ------------------------
  p "Seeding Random Properties"
  10.times do
    Property.create(
      name: Faker::Address.street_name,
      property_type: PropertyType.find(rand(1..17)),
      headline: Faker::Lorem.sentence,
      price: rand(500.00...1_000_000.00).round(2),
      rooms: rand(1..6),
      bathrooms: rand(1..3),
      square_feet: rand(100..1000),
      year_built: Time.at(rand * Time.now.to_i),
      description: Faker::Lorem.sentence(word_count: 140)
    )
  end
end

