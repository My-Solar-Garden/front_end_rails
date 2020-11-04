require 'rails_helper'

describe PlantFacade do
  it "should return plant details for specific plant" do
    response = File.read('spec/fixtures/plant_show.json')
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/plants/1").
       to_return(status: 200, body: response, headers: {})
    params = "1"
    plant = PlantFacade.plant_details(params)

    expect(plant).to be_a(Plant)
    expect(plant.name).to be_a(String)
    expect(plant.species).to be_a(String)
    expect(plant.description).to be_a(String)
    expect(plant.light_requirements).to be_a(String)
    expect(plant.water_requirements).to be_a(String)
    expect(plant.when_to_plant).to be_a(String)
    expect(plant.harvest_time).to be_a(String)
    expect(plant.common_pests).to be_a(String)
  end
end
