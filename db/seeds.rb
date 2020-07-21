# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
senator1 = Senator.create(
  first_name: "Teddy",
  last_name: "Roosevelt",
  dob: "10-10-10",
  gender: "male",
  party: "D",
)
house_member1 = HouseMember.create(
  first_name: "asdf",
  last_name: "asdf"
)
user1 = User.create(
  email: "asdf@gmail.com",
  name: "asdf",
)

user1.senator_favorites.create(
  senator_id: senator1.id,
)

user1.house_favorites.create(
  house_member_id: house_member1.id
)
