class GardenHealthService
  def self.get_parsed_json(url, params = {})
    response = conn.get(url) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.garden_health_details(params)
    get_parsed_json("/api/v1/garden_healths/#{params[:id]}")
  end

  def self.garden_health_search(start, stop, sensor_id)
    response = conn.get("/api/v1/garden_healths/search?start=#{start}&stop=#{stop}&sensor_id=#{sensor_id}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.last_reading(sensor)
    get_parsed_json("/api/v1/sensors/#{sensor.id}/garden_healths/last")
  end

  def self.get_parsed_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)[:data].first
  end

  private

  def self.conn
    Faraday.new(url: ENV['BE_URL'])
  end
end
