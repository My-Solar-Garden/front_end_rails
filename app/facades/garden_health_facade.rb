class GardenHealthFacade
  def self.garden_health_details(params, sensor_id)
    parsed_json = GardenHealthService.garden_health_details(params)
    garden_health(parsed_json, sensor_id)
  end

  def self.garden_health_search(start, stop, sensor_id)
    parsed_json = GardenHealthService.garden_health_search(start, stop, sensor_id)
    garden_health_mapped(parsed_json, sensor_id)
  end

  def self.garden_health(data, sensor_id)
    GardenHealth.new(data[:data], sensor_id)
  end

  def self.garden_health_mapped(data, sensor_id)
    data[:data].map do |garden_health|
      GardenHealth.new(garden_health, sensor_id)
    end
  end
end
