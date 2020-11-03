class GardenHealthFacade
  def self.garden_health_details(params, sensor_id)
    garden_healths = GardenHealth.new(GardenHealthService.garden_health_details(params)[:data], sensor_id)
  end
end
