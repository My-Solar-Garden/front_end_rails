class GardenHealthFacade
  def self.garden_health_details(params, sensor_id)
    parsed_json = GardenHealthService.garden_health_details(params)
    garden_health(parsed_json, sensor_id)
  end

  def self.garden_health(data, sensor_id)
    GardenHealth.new(data[:data])
  end
end
