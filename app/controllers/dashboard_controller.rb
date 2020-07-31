class DashboardController < ApplicationController
  layout "dashboard_layout"

  def show
    @house_favs = current_user.house_members
    @senator_favs = current_user.senators
    @articles = ArticleSearch.new.get_articles(all_favorites(@house_favs, @senator_favs), "relevance", "en", 6)
    @compared_reps = current_user.compared_senators(current_user.id) + current_user.compared_house_members(current_user.id)
  end

  private

  def all_favorites(members, senators)
    all_favs = members.to_a.concat(senators.to_a)
    all_favs.map(&:full_name).join(",")
  end
end
