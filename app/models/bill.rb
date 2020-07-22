class Bill < ApplicationRecord
  validates_presence_of :bill_id
  validates_presence_of :offset
end
