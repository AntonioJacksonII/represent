FactoryBot.define do
  factory :bill do
    bill_id { "hr#{Faker::Number.number(digits: 4)}-116" }
    summary_short { Faker::Lorem.paragraph }
    congress_url { "https://www.congress.gov/bill/116th-congress/house-bill/#{Faker::Number.number(digits: 4)}"}
    short_title { Faker::Lorem.sentence }
    primary_subject { Faker::IndustrySegments.sector }
  end
end
