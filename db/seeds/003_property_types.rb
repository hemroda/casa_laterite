if PropertyType.count.zero?
  puts "Seeding Property Types"

  ["Land", "Warehouse", "Factory", "Power Plant", "Special purpose", "Parking Facility", "Hotel", "Theater", "Store",
   "Shopping Center", "Office Space", "Farm", "Ranch", "Timberland", "Orchards", "Apartment Building",
   "Single-family Home", "Condominium"].each do |type|
    PropertyType.create(name: type)
  end
end
