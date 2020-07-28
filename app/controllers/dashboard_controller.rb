class DashboardController < ApplicationController
  layout "dashboard_layout"

  def show
    @house_favorites = current_user.house_members
    @senator_favorites = current_user.senators
    @articles = ArticleSearch.new.get_articles(all_favorites(@house_favorites, @senator_favorites), "relevance", "en", 6)
  end
  
  private
  
  def all_favorites(members, senators)
    all_favs = members.to_a.concat(senators.to_a)
    all_favs.map(&:full_name).join(",")
  end 
end