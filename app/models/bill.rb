class Bill < ApplicationRecord
  validates_presence_of :bill_id
  has_one :house_bill_vote, dependent: :destroy
  has_one :senate_bill_vote, dependent: :destroy

  def self.topics
    pluck(:primary_subject).uniq
  end

  def self.house_topics
    joins(:house_bill_vote).pluck(:primary_subject).uniq
  end

  def self.senate_topics
    joins(:senate_bill_vote).pluck(:primary_subject).uniq
  end
end
