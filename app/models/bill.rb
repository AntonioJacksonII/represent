class Bill < ApplicationRecord
  validates_presence_of :bill_id
  has_one :house_bill_vote, dependent: :destroy
  has_one :senate_bill_vote, dependent: :destroy

  def self.topics
    pluck(:primary_subject).uniq
  end

  def self.find_recent_five(representative)
    if representative.class == HouseMember
      Bill.joins(:house_bill_vote).where('session = ?', 2).order('house_bill_votes.roll_call DESC').limit(5)
    else
      Bill.joins(:senate_bill_vote).where('session = ?', 2).order('senate_bill_votes.roll_call DESC').limit(5)
    end
  end
end
