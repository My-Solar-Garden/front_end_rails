class GardenHealth
  attr_reader :id,
              :sensor_id,
              :reading_type,
              :reading,
              :created_at

  def initialize(data, sensor_id)
    @id = data[:id]
    @sensor_id = sensor_id
    @reading_type = data[:attributes][:reading_type]
    @reading = data[:attributes][:reading]
    @created_at = data[:attributes][:created_at]
    determine_type
  end

  def determine_type
    if @reading_type == 'light'
      @reading = ((@reading / 770) * 100).round(2)
    end
  end
end
