class GardenFacade
  def self.garden_details(params)
    parsed_json = GardenService.garden_details(params)
    garden(parsed_json)
  end

  def self.garden(data)
    Garden.new(data[:data])
  end

  def self.sensor_details(params)
    sensor = Sensor.new(GardenService.sensor_details(params)[:data])
  end

  def self.garden_health_details(params, sensor_id)
    garden_healths = GardenHealth.new(GardenService.garden_health_details(params)[:data], sensor_id)
  end
end
