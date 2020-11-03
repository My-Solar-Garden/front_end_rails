class Sensor
  attr_reader :id,
              :garden_id,
              :sensor_type,
              :min_threshold,
              :max_threshold,
              :garden_healths

  def initialize(data)
    require "pry"; binding.pry
    @id = data[:id]
    @garden_id = data[:relationships][:garden][:data][:id]
    @sensor_type = data[:attributes][:sensor_type]
    @min_threshold = data[:attributes][:min_threshold]
    @max_threshold = data[:attributes][:max_threshold]
    @garden_healths = set_garden_healths(data)
  end

  def set_garden_healths(data)
    if data[:relationships][:garden_healths][:data] != []
      data[:relationships][:garden_healths][:data].map do |garden_health|
        GardenHealthFacade.garden_health_details(garden_health, @id)
      end
    end
    # data[:relationships][:garden_healths][:data] rescue nil
  end
end
