class SensorFacade
  def self.sensor_details(params)
    sensor = Sensor.new(SensorService.sensor_details(params)[:data])
  end
end
