class User < ApplicationRecord
  has_many :house_favorites, dependent: :destroy
  has_many :house_members, through: :house_favorites
  has_many :senator_favorites, dependent: :destroy
  has_many :senators, through: :senator_favorites
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end

  def has_favorites?
    senators != [] || house_members != []
  end

  def add_comparison_score(member_id, type, results)
    if type == 'house' && house_favorites.find_by(house_member_id: member_id)
      favorite = house_favorites.find_by(house_member_id: member_id)
      favorite.update(comparison_score: results[:comparison_score])
      favorite.save
    elsif type =='senate' && senator_favorites.find_by(senator_id: member_id)
      favorite = senator_favorites.find_by(senator_id: member_id)
      favorite.update(comparison_score: results[:comparison_score])
      favorite.save
    end
  end
end
