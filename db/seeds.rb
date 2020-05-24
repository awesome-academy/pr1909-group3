# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do |n|
  User.create!(
    name: Faker::Name.delete("',^"),
    email: "admin_#{n + 1}@gmail.com",
    password: ENV["GMAIL_USERNAME"],
    password_confirmation: ENV["GMAIL_PASSWORD"],
    user_type: "admin",
    confirmed_at: Time.zone.now
  )
end

99.times do |n|
  name = Faker::Name.name
  email = "test-#{n + 1}@project1.org"
  User.create!(name: name,
               email: email,
               phone: "1234567",
               password_digest: password,
               remember_digest: password,
               role: "customer")
end
