class SensorService
  def self.new_sensor(sensor_params)
    post_parsed_json("/api/v1/sensors", sensor_params)
  end

  def self.all_sensors_for_garden(params)
    get_parsed_json("/api/v1/gardens/#{params[:id]}/sensors")
  end

  def self.delete_sensor(params)
    conn.delete("/api/v1/sensors/#{params[:id]}")
  end

  def self.post_parsed_json(url, sensor_params)
    response = conn.post(url) do |req|
      req.params = sensor_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_parsed_json(url, params= {})
    response = conn.get(url) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.conn
    Faraday.new(url: "#{ENV['BE_URL']}")
  end
end
