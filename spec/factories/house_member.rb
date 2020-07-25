FactoryBot.define do
  factory :house_member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:congress_id) {|n| "A00010#{n}" }
    sequence(:dob) {|n| "1955-09-#{n}" }
    gender { Faker::Gender.short_binary_type.upcase }
    party { "D" }
    leadership_role { nil }
    sequence(:twitter_account) {|n| "@member#{n}" }
    sequence(:facebook_account) {|n| "RepMember#{n}" }
    govtrack_id { Faker::Number.number(digits: 6) }
    sequence(:url) {|n| "https://member#{n}.house.gov" }
    sequence(:contact_form) {|n| "http://www.member#{n}.house.gov/public/index.cfm?p=Email" }
    sequence(:cook_pvi) {|n| "D + #{n}" }
    dw_nominate { Faker::Number.decimal(l_digits: 0, r_digits: 2) }
    total_votes { Faker::Number.number(digits: 3) }
    missed_votes { Faker::Number.number(digits: 3) }
    last_updated { DateTime.parse('22nd Jul 2020 15:30:29-04:00') }
    office { Faker::Address.street_address }
    sequence(:phone) {|n| "111-111-111#{n}" }
    state { Faker::Address.state_abbr }
    district { Faker::Number.number(digits: 1) }
    at_large { false }
    missed_votes_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    votes_with_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    votes_without_party_percentage { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
  end
end