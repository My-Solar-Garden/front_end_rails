class SensorFacade
  def self.sensor_details(params)
    parsed_json = SensorService.sensor_details(params)
    sensor(parsed_json)
  end

  def self.sensor(data)
    Sensor.new(data[:data])
  end
end
