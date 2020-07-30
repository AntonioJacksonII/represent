class HouseBillVote < ApplicationRecord
  validates_presence_of :offset
  validates_presence_of :roll_call
  belongs_to :bill
end
