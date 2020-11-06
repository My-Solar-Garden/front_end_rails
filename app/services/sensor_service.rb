class SensorService
  def self.sensor_details(params)
    get_parsed_json("/api/v1/sensors/#{params[:id]}")
  end

  def self.new_sensor(params)
    post_parsed_json("/api/v1/sensors", params)
  end

  def self.all_sensors_for_garden(params)
    get_parsed_json("/api/v1/gardens/#{params[:id]}/sensors")
  end

  def self.delete_sensor(params)
    conn.delete("/api/v1/sensors/#{params[:id]}")
  end

  def self.post_parsed_json(url, params)
    response = conn.post(url) do |req|
      req.params = params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.edit_sensor(params)
    patch_parsed_json("/api/v1/sensors", params)
  end

  def self.patch_parsed_json(url, params)
    response = conn.patch(url) do |req|
      req.params = params
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
