class PlantService

  def self.search_plants(search_term)
    get_parsed_json('/api/v1/plants/search', { search_term: search_term })
  end

  def self.add_plant_to_garden(params)
    conn.post("/api/v1/gardens/#{params[:id]}/plants") do |req|
      req.params = params
    end
  end

  def self.get_parsed_json(url, params = {})
    response = conn.get(url) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://solar-garden-be.herokuapp.com')
  end
end