FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "User #{n}" }
    sequence(:email) { |n| "User_#{n}@email.com" }
  end
end