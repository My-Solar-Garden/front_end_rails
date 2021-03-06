require 'rails_helper'

describe GardenService do
  xit "returns garden details data" do
    params = {id: 3}
    expected_output = File.read('spec/fixtures/updated_garden.json')
    stub_request(:post, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: expected_output, headers: {})
    response = GardenService.garden_details(params)
    garden_details_response_structure_check(response)
  end

  it 'returns create new garden response' do
    params = {"name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/new_garden.json')
    stub_request(:post, "#{ENV['BE_URL']}/api/v1/gardens?description=#{params['description']}&latitude=#{params['latitude']}&longitude=#{params['longitude']}&name=#{params['name']}&private=false&user_id=1").to_return(status: 200, body: expected_output, headers: {})

    response = GardenService.new_garden(params.symbolize_keys, "1")
    garden_details_response_structure_check(response)
  end

  it 'can delete a garden and receive a blank response' do
    params = {"id" => "1", "name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/delete_garden.json')
    stub_request(:delete, "#{ENV['BE_URL']}/api/v1/gardens/#{params["id"]}").to_return(status: 204, body: expected_output, headers: {})

    response = GardenService.destroy(params["id"])
    expect(response.body).to eq("")
  end

  xit 'can edit a garden' do
    params = {"id" => "4", "name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/updated_garden.json')
    stub_request(:delete, "https://solar-garden-be.herokuapp.com/api/v1/gardens/#{params["id"]}").to_return(status: 204, body: expected_output, headers: {})

    response = GardenService.update(params, "4")
    garden_details_response_structure_check(response)
  end
end
