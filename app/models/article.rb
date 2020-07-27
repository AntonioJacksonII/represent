class Article
  attr_reader :source, :title, :description, :url, :published_at

  def initialize(article_info)
    @source = article_info[:source]
    @title = article_info[:title]
    @description = article_info[:description]
    @url = article_info[:url]
    @published_at = article_info[:published_at]
  end
end 