require 'rails_helper'

describe GardenService do
  it "returns garden details data" do
    params = {id: 1}
    garden_data = GardenService.garden_details(params)

    expect(garden_data).to have_key(:data)
    expect(garden_data[:data]).to be_a(Hash)

    expect(garden_data[:data]).to have_key(:id)
    expect(garden_data[:data][:id]).to be_a(String)

    expect(garden_data[:data]).to have_key(:type)
    expect(garden_data[:data][:type]).to be_a(String)

    expect(garden_data[:data]).to have_key(:attributes)
    expect(garden_data[:data][:attributes]).to be_a(Hash)

    expect(garden_data[:data][:attributes]).to have_key(:latitude)
    expect(garden_data[:data][:attributes][:latitude]).to be_a(Float)

    expect(garden_data[:data][:attributes]).to have_key(:longitude)
    expect(garden_data[:data][:attributes][:longitude]).to be_a(Float)

    expect(garden_data[:data][:attributes]).to have_key(:name)
    expect(garden_data[:data][:attributes][:name]).to be_a(String)

    expect(garden_data[:data][:attributes]).to have_key(:description)
    expect(garden_data[:data][:attributes][:description]).to be_a(String)

    expect(garden_data[:data][:attributes]).to have_key(:private)
    expect(garden_data[:data][:attributes][:private]).to be_in([true, false])

    expect(garden_data[:data]).to have_key(:relationships)
    expect(garden_data[:data][:relationships]).to be_a(Hash)

    expect(garden_data[:data][:relationships]).to have_key(:user_gardens)
    expect(garden_data[:data][:relationships][:user_gardens]).to be_a(Hash)

    expect(garden_data[:data][:relationships]).to have_key(:users)
    expect(garden_data[:data][:relationships][:users]).to be_a(Hash)

    expect(garden_data[:data][:relationships]).to have_key(:sensors)
    expect(garden_data[:data][:relationships][:sensors]).to be_a(Hash)

    expect(garden_data[:data][:relationships]).to have_key(:garden_plants)
    expect(garden_data[:data][:relationships][:garden_plants]).to be_a(Hash)
  end
end
