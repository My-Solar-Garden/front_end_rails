class GardenFacade
  def self.create_garden_objects(users_gardens)
    users_gardens.map do |garden|
      garden_details(garden)
    end
  end

  def self.garden_details(params)
    parsed_json = GardenService.garden_details(params)
    garden(parsed_json)
  end

  def self.garden(data)
    Garden.new(data[:data])
  end

  def self.new_garden(params, current_user_id)
    GardenService.new_garden(params, current_user_id)
  end

  def self.update(params, current_user_id)
    GardenService.update(params, current_user_id)
  end

  def self.destroy(garden_id)
    GardenService.destroy(garden_id)
  end
end
