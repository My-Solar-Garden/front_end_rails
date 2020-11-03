class PlantFacade
  def self.search(search_term)
    PlantService.search(search_term).map do |plant_data|
      PlantPoro.new(plant_data)
    end
  end
end