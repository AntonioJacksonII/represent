class Bill < ApplicationRecord
  validates_presence_of :bill_id
  has_one :house_bill_vote, dependent: :destroy
  has_one :senate_bill_vote, dependent: :destroy

  def self.topics
    pluck(:primary_subject)
  end
end
