if Account.count.zero?
  puts "Seeding First Account"
  Account.create(first_name: "Rakoto",
                 last_name: "Rabezafy",
                 phone_number: "0701010101",
                 email: "rrabezafy@account.com",
                 password: "password",
                 password_confirmation: "password",
                 confirmed: true,
                 confirmed_at: Time.now)

  puts "Seeding Random Accounts"
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
