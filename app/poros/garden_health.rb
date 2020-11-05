class GardenHealth
  attr_reader :id, :reading_type, :reading, :created_at
  def initialize(data)
    @id = data[:attributes][:id]
    @reading_type = data[:attributes][:reading_type]
    @reading = data[:attributes][:reading]
    @created_at = data[:attributes][:created_at]
  end
end
