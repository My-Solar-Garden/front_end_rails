require 'rails_helper'

describe GardenService do
  it "returns garden details data" do
    params = {id: 1}
    response = GardenService.garden_details(params)
    garden_details_response_structure_check(response)
  end

  it 'returns create new garden response' do
    params = {"name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/new_garden.json')
    stub_request(:post, "https://solar-garden-be.herokuapp.com/api/v1/gardens?description=#{params['description']}&latitude=#{params['latitude']}&longitude=#{params['longitude']}&name=#{params['name']}&private=false&user_id=1").to_return(status: 200, body: expected_output, headers: {})

    response = GardenService.new_garden(params.symbolize_keys, "1")

    garden_details_response_structure_check(response)
  end
end
