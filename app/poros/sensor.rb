class Sensor
  attr_reader :id,
              :garden_id,
              :sensor_type,
              :min_threshold,
              :max_threshold

  def initialize(data)
    @id = data[:id]
    @garden_id = data[:relationships][:garden][:data][:id]
    @sensor_type = data[:attributes][:sensor_type]
    @min_threshold = data[:attributes][:min_threshold]
    @max_threshold = data[:attributes][:max_threshold]
  end
end
