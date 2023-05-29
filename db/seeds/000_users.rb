if User.count.zero?
  User.create(
    first_name: "John",
    last_name: "Smith",
    phone_number: "0601010101",
    email: "jsmith@laterite.casa",
    role: 2,
    password: "password",
    password_confirmation: "password"
  )
  User.create(
    first_name: "Tom",
    last_name: "Dunno",
    phone_number: "0602020202",
    email: "tdunno@laterite.casa",
    role: 1,
    password: "password",
    password_confirmation: "password"
  )
  User.create(
    first_name: "Karin",
    last_name: "Pleams",
    phone_number: "0603030303",
    email: "kpleams@laterite.casa",
    role: 0,
    password: "password",
    password_confirmation: "password"
  )

  puts "Seeding random Users"
  20.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
      first_name: first_name,
      last_name: last_name,
      email: "#{first_name.downcase!}.#{last_name.downcase!}@laterite.casa",
      password: "password",
      password_confirmation: "password",
      phone_number: Faker::PhoneNumber.cell_phone,
      role: 0,
      locale: "#{1 if User.last.id % 2}".to_i
    )
  end
end
