class GardenFacade
  def self.garden_details(params)
    parsed_json = GardenService.garden_details(params)
    garden(parsed_json)
  end

  def self.garden(data)
    Garden.new(data[:data])
  end

  def self.sensor_details
    require "pry"; binding.pry
    sensor = Sensor.new(GardenService.sensor_details)
  end
end
