class SensorFacade
  def self.sensor_details(params)
    parsed_json = SensorService.sensor_details(params)
    sensor(parsed_json)
  end

  def self.new_sensor(params)
    parsed_json = SensorService.new_sensor(params)
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

  def self.edit_sensor(params)
    parsed_json = SensorService.edit_sensor(params)
    sensor(parsed_json)
  end
end
