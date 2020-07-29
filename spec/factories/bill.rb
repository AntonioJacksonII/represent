FactoryBot.define do
  factory :bill do
    bill_id { "hr1957-116" }
    summary_short { Faker::TvShows::DumbAndDumber.quote }
    sequence(:congress_url) { |n| "https://bill#{n}.house.gov" }
    short_title { Faker::GreekPhilosophers.quote }
    primary_subject { Faker::Lorem.word }
    offset { Faker::Number.number(digits: 2) }
    passage_roll_call { Faker::Number.number(digits: 3) }
  end
end