require 'rails_helper'

describe 'Article' do
  before(:each) do
    @article = Article.new({source: "Reuters", 
                            title: "Title 1", 
                            description: "Article description", 
                            url: "www.reuters.com", 
                            published_at: "2020-07-01T19:38:00Z"})
  end
  it 'exists' do
    expect(@article).to be_a(Article)
  end

  it 'attributes' do
    expect(@article.source).to eq("Reuters")
    expect(@article.title).to eq("Title 1")
    expect(@article.description).to eq("Article description")
    expect(@article.url).to eq("www.reuters.com")
    expect(@article.published_at).to eq("2020-07-01T19:38:00Z")
  end
end