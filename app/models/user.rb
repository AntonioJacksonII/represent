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
<<<<<<< HEAD
    end
  end
=======
    end 
  end 

  def has_favorites?
    senators != [] || house_members != []
  end 

  def compared_senators
    senators.joins(:senator_favorites)
            .where('senator_favorites.comparison_score IS NOT NULL' )
  end 

  def compared_house_members
    house_members.joins(:house_favorites)
                 .where('house_favorites.comparison_score IS NOT NULL' )
  end 
>>>>>>> master
end
