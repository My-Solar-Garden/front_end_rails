class SensorFacade
  def self.new_sensor(sensor_params)
    parsed_json = SensorService.new_sensor(sensor_params)
    sensor(parsed_json)
  end

  def self.sensor(data)
    Sensor.new(data)
  end
end
