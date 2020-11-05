class SensorFacade
  def self.new_sensor(sensor_params)
    parsed_json = SensorService.new_sensor(sensor_params)
    sensor(parsed_json)
  end

  def self.all_sensors_for_garden(params)
    parsed_json = SensorService.all_sensors_for_garden(params)
    parsed_json.map { |sensor_data| sensor(sensor_data) }
  end

  def self.sensor(data)
    Sensor.new(data)
  end

  def self.edit_sensor(sensor_params)
    parsed_json = SensorService.edit_sensor(sensor_params)
    sensor(parsed_json)
  end

  def self.sensor_details(sensor_params)
    # binding.pry
    parsed_json = SensorService.sensor_details(sensor_params)
    sensor(parsed_json)
  end
end
