class Senator < ApplicationRecord
  def self.by_state(state_abbrev, order = 'asc', limit = 400)
    self.where(state: "#{state_abbrev}")
        .order(last_name: "#{order}")
        .limit(limit)
  end 

  def full_name
    "#{first_name} #{last_name}"
  end 
end
