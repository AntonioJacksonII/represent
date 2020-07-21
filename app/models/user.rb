class User < ApplicationRecord
  has_many :house_favorites
  has_many :house_members, through: :house_favorites
  has_many :senator_favorites
  has_many :senators, through: :senator_favorites
  validates_presence_of :email
  validates_presence_of :name
end
