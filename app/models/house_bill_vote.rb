class HouseBillVote < ApplicationRecord
  validates_presence_of :session
  validates_presence_of :roll_call
  belongs_to :bill
end
