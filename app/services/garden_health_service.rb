class GardenHealthService
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
