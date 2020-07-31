class SenatorFavorite < ApplicationRecord
  belongs_to :senator
  belongs_to :user
end
