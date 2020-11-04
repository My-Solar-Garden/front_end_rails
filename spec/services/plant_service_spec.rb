require 'rails_helper'

describe PlantService do
  it "returns plant details data" do
    response = File.read('spec/fixtures/plant_show.json')
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/plants/1").
       to_return(status: 200, body: response, headers: {})
    plant = PlantService.plant_details('1')

    expect(plant).to be_a(Hash)
    expect(plant).to have_key(:data)
    expect(plant[:data]).to have_key(:id)
    expect(plant[:data][:id]).to be_a(String)
    expect(plant[:data]).to have_key(:type)
    expect(plant[:data]).to have_key(:attributes)
    expect(plant[:data][:attributes]).to be_a(Hash)
    expect(plant[:data][:attributes]).to have_key(:image)
    expect(plant[:data][:attributes][:image]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:name)
    expect(plant[:data][:attributes][:name]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:species)
    expect(plant[:data][:attributes][:species]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:description)
    expect(plant[:data][:attributes][:description]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:light_requirements)
    expect(plant[:data][:attributes][:light_requirements]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:water_requirements)
    expect(plant[:data][:attributes][:water_requirements]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:when_to_plant)
    expect(plant[:data][:attributes][:when_to_plant]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:harvest_time)
    expect(plant[:data][:attributes][:harvest_time]).to be_a(String)
    expect(plant[:data][:attributes]).to have_key(:common_pests)
    expect(plant[:data][:attributes][:common_pests]).to be_a(String)
  end
end
