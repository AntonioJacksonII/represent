class HouseMember < ApplicationRecord
  has_many :house_favorites, dependent: :destroy
  has_many :users, through: :house_member_favorites
  def self.by_state(state_abbrev, order = 'asc', limit = 400)
    self.where(state: "#{state_abbrev}")
        .order(last_name: "#{order}")
        .limit(limit)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.includes?(congress_id)
    self.exists?(congress_id: "#{congress_id}")
  end

  def self.house_favorites_for_user(id)
    HouseMember.joins(house_favorites:[:user]).where('house_favorites.comparison_score IS NOT NULL AND house_favorites.user_id = ?', id)
  end
end
