class Bill < ApplicationRecord
  validates_presence_of :bill_id
  validates_presence_of :offset
  has_one :house_bill_vote, dependent: destroy
  has_one :senate_bill_vote, dependent: destroy

  def self.topics
    pluck(:primary_subject)
  end
end
