class PlantService
  def self.plant_details(id)
    response = Faraday.get("#{ENV['BE_URL']}/api/v1/plants/#{id}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
