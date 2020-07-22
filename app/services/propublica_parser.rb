class PropublicaParser
  def self.parse_house_members(json_response)
    house_reps = JSON.parse(json_response, symbolize_names: true)
    binding.pry
  end

  def self.parse_senators(json_response)
    senators = JSON.parse(json_response, symbolize_names: true)
    binding.pry
  end
end
