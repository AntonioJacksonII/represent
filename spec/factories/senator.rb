FactoryBot.define do
  factory :senator do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:congress_id) {|n| "A00010#{n}" }
    dob {"1955-#{Faker::Number.between(from: 1, to: 12)}-#{Faker::Number.between(from: 1, to: 28)}" }
    gender { Faker::Gender.short_binary_type.upcase }
    party { "D" }
    leadership_role { nil }
    sequence(:twitter_account) {|n| "@senator#{n}" }
    sequence(:facebook_account) {|n| "RepSenator#{n}" }
    govtrack_id { Faker::Number.number(digits: 6) }
    sequence(:url) {|n| "https://senator#{n}.senate.gov" }
    sequence(:contact_form) {|n| "http://www.senator#{n}.senate.gov/public/index.cfm?p=Email" }
    dw_nominate { Faker::Number.decimal(l_digits: 0, r_digits: 2) }
    next_election { 2020 }
    total_votes { Faker::Number.number(digits: 3) }
    missed_votes { Faker::Number.number(digits: 3) }
    last_updated { DateTime.parse('22nd Jul 2020 15:30:29-04:00') }
    office { Faker::Address.street_address }
    sequence(:phone) {|n| "111-111-111#{n}" }
    state { Faker::Address.state_abbr }
    senate_class { 1 }
    state_rank { "junior" }
    missed_votes_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    votes_with_percentage { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    votes_without_party_percentage { Faker::Number.decimal(l_digits: 1, r_digits: 2) }
  end
end
