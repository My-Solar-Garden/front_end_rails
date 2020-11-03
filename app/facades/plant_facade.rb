class PlantFacade

  def self.search_plants(search_term)
    PlantService.search_plants(search_term).map do |plant_info| 
      Plant.new(plant_info)
    end
  end

end