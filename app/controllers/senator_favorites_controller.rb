class SenatorFavoritesController < ApplicationController

  def create
    if !current_user.nil?
      create_senator_favorite(params[:id])
      flash[:notice] = "Successfully added to favorites"
      redirect_to senator_path(params[:id])
    else
      flash.now[:alert] = "You must be signed in to favorite a senator"
    end
  end

  def destroy
    delete_senator_favorite(params[:id])
    flash[:notice] = "Successfully removed from favorites"
    redirect_to senator_path(params[:id])
  end

  private

  def create_senator_favorite(id)
    SenatorFavorite.create(
      user_id: current_user.id
      senator_id: id
    )
  end

  def delete_senator_favorite(id)
    member = current_user.senator_favorites.find_by(senator_id: id)
    member.destroy
  end
end
