class RequestService
  def get_representatives
    get_json('representatives')
  end

  def get_senators
    get_json('senators')
  end

  def get_articles(favorite_names, sort, language_abbrev, num_results)
    params = { favorite_names: "\"#{favorite_names}\"", sort: sort, language: language_abbrev, num_results: num_results}

    get_json('articles', params)
  end

  private

  def get_json(url, params = nil)
    response = conn.get(url, params) do |request|
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  # def conn
  #   Faraday.new(url: 'https://floating-cliffs-29262.herokuapp.com/api/v1/') do |f|
  #     f.adapter Faraday.default_adapter
  #   end
  # end

  def conn
    Faraday.new(url: 'http://localhost:4567/api/v1/') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end 