class PlantPoro
  attr_reader :image,
              :name,
              :species,
              :description,
              :light_requirements,
              :water_requirements,
              :when_to_plant,
              :harvest_time,
              :common_pests,
              :id
  def initialize(data)
    @image = data[:image_url]
    @name = data[:name]
    @species = ""
    @description = data[:description]
    @light_requirements = data[:optimal_sun]
    @water_requirements = data[:watering]
    @when_to_plant = data[:when_to_plant]
    @harvest_time = data[:harvesting]
    @common_pests = data[:pests]
    @id = data[:id]
  end
end