class Plant
  attr_reader :id,
              :image,
              :name,
              :species,
              :description,
              :light_requirements,
              :water_requirements,
              :when_to_plant,
              :harvest_time,
              :comment_pests
              
  def initialize(data)
    @id = data[:id]
    @image = data[:attributes][:image]
    @name = data[:attributes][:name]
    @species = data[:attributes][:species]
    @description = data[:attributes][:description]
    @light_requirements = data[:attributes][:light_requirements]
    @water_requirements = data[:attributes][:water_requirements]
    @when_to_plant = data[:attributes][:when_to_plant]
    @harvest_time = data[:attributes][:harvest_time]
    @comment_pests = data[:attributes][:comment_pests]
  end
end
