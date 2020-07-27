class FavoritesController < ApplicationController
  def update
    senator = Senator.find(params[:senator_id]) if params[:senator_id]
    house_member = HouseMember.find(params[:house_id]) if params[:house_id]
    if favorites.contents.include?(senator.id)
      message = "#{senator.name} has been removed from favorites"
      favorites.update_senator(senator.id)
    elsif favorites.contents.include?(house_member.id)
      message = "#{house_member.name} has been removed from favorites"
      favorites.update_house(house_member.id)
    elsif senator
      message = "#{senator.name} has been added to your favorites"
      favorites.update_senator(senator.id)
    else
      message = "#{house_member.name} has been added to your favorites"
      favorites.update_house(house_member.id)
  end

  def destroy
    favorites.contents.clear
    redirect_to "/"
  end
end
