class Senator < ApplicationRecord

  def self.by_state(state_abbrev)
    where(state: "#{state_abbrev}")
  end

  def full_name
    "#{first_name} #{last_name}"
  end 
end
