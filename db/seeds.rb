# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
99.times do |n|
  name = Faker::Name.name
  email = "test-#{n + 1}@project1.org"
  User.create! name: name,
               email: email,
               address: Faker::Lorem.paragraph(1),
               phone: "1234567",
               password_digest: password,
               remember_digest: password,
               role: "customer"
end
