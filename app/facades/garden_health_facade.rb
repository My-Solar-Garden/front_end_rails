class GardenHealthFacade
  def self.last_reading(sensor)
    parsed_json = GardenHealthService.last_reading(sensor)
    garden_health(parsed_json)
  end

  def self.garden_health(data)
    GardenHealth.new(data)
  end
end
