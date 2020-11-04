class PlantFacade
  def self.search_plants(search_term)
    PlantService.search_plants(search_term)[:data].map do |plant_info| 
      Plant.new(plant_info)
    end
  end

  def self.add_plant_to_garden(params)
    PlantService.add_plant_to_garden(params)
  end
end