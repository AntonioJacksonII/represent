FactoryBot.define do
  factory :senator do
    sequence(:first_name) {|n| "Member #{n}" }
    sequence(:last_name) {|n| "Member #{n}" }
    sequence(:congress_id) {|n| "A00010#{n}" }
    sequence(:dob) {|n| "1955-09-#{n}" }
    gender { "M" }
    party { "D" }
    leadership_role { nil }
    sequence(:twitter_account) {|n| "@member#{n}" }
    sequence(:facebook_account) {|n| "RepMember#{n}" }
    govtrack_id { Faker::Number.number(digits: 6) }
    sequence(:url) {|n| "https://member#{n}.house.gov" }
    sequence(:contact_form) {|n| "http://www.member#{n}.senate.gov/public/index.cfm?p=Email" }
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