require 'rails_helper'

describe GardenFacade do
  xit "should return garden details for specific garden" do
    params = {id: 3}
    expected_output = File.read('spec/fixtures/updated_garden.json')
    stub_request(:post, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: expected_output, headers: {})
    garden = GardenFacade.garden_details(params)

    expect(garden).to be_a(Garden)
  end

  it "should generate garden poros" do
    data = {:data=>
                    {:id=>"1",
                     :type=>"garden",
                     :attributes=>{:latitude=>41.0, :longitude=>41.0, :name=>"A garden", :description=>"a garden", :private=>nil},
                     :relationships=>{:user_gardens=>{:data=>[]}, :users=>{:data=>[]}, :sensors=>{:data=>[{:id=>"1", :type=>"sensor"}, {:id=>"2", :type=>"sensor"}]}, :garden_plants=>{:data=>[]}, :plants=>{:data=>[]}}}}

    garden = GardenFacade.garden(data)
  end

  it "can create a new garden (no need to return as garden object)" do
    params = {"name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/new_garden.json')
    stub_request(:post, "#{ENV['BE_URL']}/api/v1/gardens?description=#{params['description']}&latitude=#{params['latitude']}&longitude=#{params['longitude']}&name=#{params['name']}&private=false&user_id=1").to_return(status: 200, body: expected_output, headers: {})

    response = GardenFacade.new_garden(params.symbolize_keys, "1")
    garden_details_response_structure_check(response)
  end

  it 'can delete a garden (no need for return value)' do
    params = {"id" => "1", "name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/delete_garden.json')
    stub_request(:delete, "#{ENV['BE_URL']}/api/v1/gardens/#{params["id"]}").to_return(status: 204, body: expected_output, headers: {})

    response = GardenFacade.destroy(params["id"])
    expect(response.body).to eq("")
  end

  xit 'can edit a garden' do
    params = {"id" => "4", "name"=>"The Grove", "latitude"=>"71.0", "longitude"=>"25.0", "private"=>"false", "description"=>"My first garden"}

    expected_output = File.read('spec/fixtures/updated_garden.json')
    stub_request(:delete, "https://solar-garden-be.herokuapp.com/api/v1/gardens/#{params["id"]}").to_return(status: 204, body: expected_output, headers: {})

    response = GardenFacade.update(params, "4")
    garden_details_response_structure_check(response)
  end
end
