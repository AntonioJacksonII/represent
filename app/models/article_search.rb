class ArticleSearch
  def get_articles(favorite_names, sort, language_abbrev, num_results)
    service.get_articles(favorite_names, sort, language_abbrev, num_results)[:data].map do |data|
      Article.new(data)
    end
  end 

  def service
    SinatraService.new
  end
end