class DashboardController < ApplicationController
  layout "dashboard_layout"

  def show
    @house_favs = current_user.house_members
    @senator_favs = current_user.senators
    @articles = ArticleSearch.new.get_articles(all_favorites(@house_favs, @senator_favs), "relevance", "en", 6)
    @compared_reps = HouseMember.house_favorites_for_user(current_user.id) + Senator.senator_favorite_for_user(current_user.id)
    @service = SinatraService.new
  end

  private

  def all_favorites(members, senators)
    all_favs = members.to_a.concat(senators.to_a)
    all_favs.map(&:full_name).join(",")
  end
end
