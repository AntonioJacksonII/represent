# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
HouseMember.create!(congress_id: "A000374",
first_name: "Ralph",
last_name: "Abraham",
dob: "1954-09-16",
gender: "M",
party: "R",
twitter_account: "RepAbraham",
facebook_account: "CongressmanRalphAbraham",
govtrack_id: "412630",
url: "https://abraham.house.gov",
cook_pvi: "R+15",
dw_nominate: 0.54,
total_votes: 853,
missed_votes: 292,
last_updated: "2020-07-22 15:30:29 -0400",
office: "417 Cannon House Office Building",
phone: "202-225-8490",
state: "LA",
district: 5,
at_large: false,
missed_votes_percentage: 34.23,
votes_with_percentage: 94.78,
votes_without_party_percentage: 5.04)
