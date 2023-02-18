# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies: Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  # USERS
  # ---------------------------------------
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

    p "Seeding random Users"
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

  # ACCOUNTS
  if Account.count.zero?
    p "Seeding First Account"
    Account.create(first_name: "Rakoto",
                   last_name: "Rabezafy",
                   phone_number: "0701010101",
                   email: "rrabezafy@account.com",
                   password: "password",
                   password_confirmation: "password",
                   confirmed: true,
                   confirmed_at: Time.now)

    p "Seeding Random Accounts"
    15.times do |index|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      confirmed = index.odd? ? true : false
      confirmed_at = index.odd? ? Time.now : nil
      Account.create(
        first_name: first_name.capitalize,
        last_name: last_name.capitalize,
        email: "#{first_name.downcase!}.#{last_name.downcase!}@account.com",
        password: "password",
        password_confirmation: "password",
        phone_number: Faker::PhoneNumber.cell_phone,
        confirmed: confirmed,
        confirmed_at: confirmed_at
      )
    end
  end
end
