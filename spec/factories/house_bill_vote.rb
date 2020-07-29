FactoryBot.define do
  factory :house_bill_vote do
    roll_call { 100 }
    offset { 20 }
    bill
  end
end