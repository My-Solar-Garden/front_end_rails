class SensorFacade
  def self.new_sensor(sensor_params)
    parsed_json = SensorService.new_sensor(sensor_params)
    sensor(parsed_json)
  end

  def self.all_sensors_for_garden(params)
    parsed_json = SensorService.all_sensors_for_garden(params)
    parsed_json.map { |sensor_data| sensor(sensor_data) }
  end

  def self.delete_sensor(params)
    SensorService.delete_sensor(params)
  end

  def self.sensor(data)
    Sensor.new(data)
  end
end
