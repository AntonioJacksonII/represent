class SenatorFavoritesController < ApplicationController

  def create
    create_senator_favorite
  end

  private

  def seantor_favorite_params
    params.permit(:id)
  end

  def create_senator_favorite
    current_user.senator_favorite.create(
      senator_id: senator_favorite_params
    )
end
