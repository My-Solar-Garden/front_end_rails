class GardenHealth
  attr_reader :id,
              :sensor_id,
              :reading_type,
              :reading,
              :created_at

  def initialize(data)
    @id = data[:id]
    @sensor_id = data[:sensor_id]
    @reading_type = data[:reading_type]
    @reading = data[:reading]
    @created_at = data[:created_at]
  end
end
