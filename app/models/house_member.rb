class HouseMember < ApplicationRecord

  def self.by_state(state_abbrev)
    where(state: "#{state_abbrev}")
  end 
end
