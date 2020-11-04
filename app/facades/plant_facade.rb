class PlantFacade
  def self.plant_details(id)
    plant_parsed = PlantService.plant_details(id)
    Plant.new(plant_parsed[:data])
  end
end
