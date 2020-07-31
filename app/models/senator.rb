class Senator < ApplicationRecord
  has_many :senator_favorites, dependent: :destroy
  has_many :users, through: :senator_favorites
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

  def self.senator_favorite_for_user(id)
    Senator.joins(senator_favorites:[:user]).where('senator_favorites.comparison_score IS NOT NULL AND senator_favorites.user_id = ?', id)
  end
end
