class GardenHealthService
  def self.get_parsed_json(url, params = {})
    response = conn.get(url) do |req|
      req.params = params
    end
    require "pry"; binding.pry
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.garden_health_details(params)
    get_parsed_json("/api/v1/garden_healths/#{params[:id]}")
  end

  def self.garden_health_search(start, stop, sensor_id)
    get_parsed_json("/api/v1/garden_healths/search?start=#{start}&stop=#{stop}&sensor_id=#{sensor_id}")
  end

  def self.conn
    Faraday.new(url: 'https://solar-garden-be.herokuapp.com')
  end
end
