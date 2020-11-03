class SensorService
  def self.new_sensor(sensor_params)
    post_parsed_json("api/v1/sensors", sensor_params)
  end

  def self.post_parsed_json(url, sensor_params)
    response = conn.post do |req|
      req.params = sensor_params
    end
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.conn
    Faraday.new(url: 'https://solar-garden-be.herokuapp.com/api/v1/sensors')
  end
end
