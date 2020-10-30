class Garden

  attr_reader :id, :name, :latitude, :longitude, :description, :private

  def initialize(data)
    @id = data[:id]
    @name = data[:attributes][:name]
    @latitude = data[:attributes][:latitude]
    @longitude = data[:attributes][:longitude]
    @description = data[:attributes][:description]
    @private = data[:attributes][:private]
  end
end
