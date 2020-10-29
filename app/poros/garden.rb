class Garden
  attr_reader :id,
              :latitude,
              :longitude,
              :name,
              :description,
              :plants,
              :sensors
              
  def initialize(data)
    @id = data[:id]
    @longitude = data[:attributes][:longitude]
    @latitude = data[:attributes][:latitude]
    @name = data[:attributes][:name]
    @description = data[:attributes][:description]
    @plants = data[:relationships][:plants][:data]
    @sensors = data[:relationships][:sensors][:data]
  end
end
