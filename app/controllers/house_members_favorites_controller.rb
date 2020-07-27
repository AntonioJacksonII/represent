class HouseMembersFavoritesController < ApplicationController
  def create
    if !current_user.nil?
      create_house_favorite(params[:id])
      flash[:notice] = "Successfully added to favorites"
      redirect_to house_member_path(params[:id])
    else
      flash.now[:alert] = "You must sign in to favorite a member"
    end
  end

  def destroy
    delete_house_favorite(params[:id])
    flash[:notice] = "Successfully removed from favorites"
    redirect_to house_member_path(params[:id])
  end

  private

  def create_house_favorite(id)
    current_user.house_favorites.create(
      house_member_id: id
    )
  end

  def delete_house_favorite(id)
    member = current_user.house_favorites.find_by(house_member_id: id)
    member.destroy
  end
end
