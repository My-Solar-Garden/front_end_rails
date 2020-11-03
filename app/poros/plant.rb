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
              :common_pests,
              :gardens

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
    @common_pests = data[:attributes][:common_pests]
    @gardens = set_gardens(data)
  end

  def set_gardens(data)
    data[:relationships][:gardens][:data] rescue nil
  end
end
