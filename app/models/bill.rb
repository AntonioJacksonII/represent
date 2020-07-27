class Bill < ApplicationRecord
  validates_presence_of :bill_id
  validates_presence_of :offset

  def self.topics
    pluck(:primary_subject)
  end
end
