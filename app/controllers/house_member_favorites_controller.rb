class HouseMemberFavoritesController < ApplicationController
  def create
    if current_user
      create_house_favorite(member)
    end
  end

  private

  def house_params
    params.permit(:id)
  end

  def create_house_favorite(member)
    current_user.house_favorite.create(
      house_member_id: house_params
    )
  end
end
