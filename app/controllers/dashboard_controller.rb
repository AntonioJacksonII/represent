class DashboardController < ApplicationController
  def show
    # @house_favorites = current_user.house_favorites
    # @senator_favorites = current_user.senator_favorites
    # @news_articles = ArticleSearch.new.get_articles(all_favorites(@house_favorites, @senator_favorites), "en", "popularity", 5)
  end

  # def all_favorites(members, senators)
  #   # Need to combine members names and senators names into one array
  # end 
end