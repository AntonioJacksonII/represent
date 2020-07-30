class SinatraService

  def get_house_members
    get_json('/api/v1/representatives')
  end

  def get_senators
    get_json('/api/v1/senators')
  end

  def get_articles(favorite_names, sort, language_abbrev, num_results)
    params = { favorite_names: "\"#{favorite_names}\"", sort: sort,
               language: language_abbrev, num_results: num_results}

    get_json('/api/v1/articles', params)
  end

  def get_bills
    get_json('/api/v1/bills')
  end

  def get_member_votes(member_id, offset)
    params = { member_id: member_id, offset: offset}

    get_json_not_symbolized('/api/v1/member_votes', params)
  end

  private

  # def conn
  #   Faraday.new(url: "http://floating-cliffs-29262.herokuapp.com") do |f|
  #     f.adapter Faraday.default_adapter
  #   end
  # end

  def conn
    Faraday.new(url: "http://localhost:4568") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url, params = nil)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_json_not_symbolized(url, params = nil)
    response = conn.get(url, params)
    JSON.parse(response.body)
  end
end
