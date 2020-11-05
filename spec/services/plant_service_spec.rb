require 'rails_helper'

describe PlantService do
  it "returns all plants related to a garden" do
    json_response = File.read('spec/fixtures/plants.json')

    stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/247/plants").to_return(status: 200, body: json_response)

    params = {id: 247}

    response = PlantService.all_plants_for_garden(params)

    expect(response[:data]).to be_an(Array)
  end
end
