FactoryBot.define do
  factory :senate_bill_vote do
    roll_call { 100 }
    session { 1 }
    bill
  end
end
