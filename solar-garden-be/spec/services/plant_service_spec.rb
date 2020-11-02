require 'rails_helper'
RSpec.describe PlantService do
  it 'returns plant data', :vcr do
    plants = PlantService.all_plants
    expect(plants).to be_an Array
    plant_data = plants.first
    expect(plant_data).to have_key :image_url
    expect(plant_data[:image_url]).to be_a(String)
    expect(plant_data).to have_key :name
    expect(plant_data[:name]).to be_a(String)
    expect(plant_data).to have_key :description
    expect(plant_data[:description]).to be_a(String)
    expect(plant_data).to have_key :optimal_sun
    expect(plant_data[:optimal_sun]).to be_a(String)
    expect(plant_data).to have_key :watering
    expect(plant_data[:watering]).to be_a(String)
    expect(plant_data).to have_key :when_to_plant
    expect(plant_data[:when_to_plant]).to be_a(String)
    expect(plant_data).to have_key :harvesting
    expect(plant_data[:harvesting]).to be_a(String)
    expect(plant_data).to have_key :pests
  end

  it 'returns plant data', :vcr do
    plants = PlantService.search('on')
    expect(plants).to be_an Array
    plant_data = plants.first
    expect(plant_data).to have_key :image_url
    expect(plant_data[:image_url]).to be_a(String)
    expect(plant_data).to have_key :name
    expect(plant_data[:name]).to be_a(String)
    expect(plant_data[:name].downcase.include?('on')).to eq(true)
    expect(plant_data).to have_key :description
    expect(plant_data[:description]).to be_a(String)
    expect(plant_data).to have_key :optimal_sun
    expect(plant_data[:optimal_sun]).to be_a(String)
    expect(plant_data).to have_key :watering
    expect(plant_data[:watering]).to be_a(String)
    expect(plant_data).to have_key :when_to_plant
    expect(plant_data[:when_to_plant]).to be_a(String)
    expect(plant_data).to have_key :harvesting
    expect(plant_data[:harvesting]).to be_a(String)
    expect(plant_data).to have_key :pests
  end
end