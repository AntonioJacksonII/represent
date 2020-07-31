class HouseFavorite < ApplicationRecord
  belongs_to :house_member
  belongs_to :user
end
