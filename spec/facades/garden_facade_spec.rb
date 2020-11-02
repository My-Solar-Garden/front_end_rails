require 'rails_helper'

describe GardenFacade do
  it "should return garden details for specific garden" do
    params = {id: 1}
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
    stub_request(:post, "https://solar-garden-be.herokuapp.com/api/v1/gardens?description=#{params[:description]}&latitude=#{params[:latitude]}&longitude=#{params[:longitude]}&name=#{params[:name]}&private=false&user_id=1").to_return(status: 200, body: expected_output, headers: {})

    response = GardenFacade.new_garden(params.symbolize_keys, "1")

    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)

    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_a(String)

    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to be_a(String)

    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to be_a(Hash)

    expect(response[:data][:attributes]).to have_key(:latitude)
    expect(response[:data][:attributes][:latitude]).to be_a(Float)

    expect(response[:data][:attributes]).to have_key(:longitude)
    expect(response[:data][:attributes][:longitude]).to be_a(Float)

    expect(response[:data][:attributes]).to have_key(:name)
    expect(response[:data][:attributes][:name]).to be_a(String)

    expect(response[:data][:attributes]).to have_key(:description)
    expect(response[:data][:attributes][:description]).to be_a(String)

    expect(response[:data][:attributes]).to have_key(:private)
    expect(response[:data][:attributes][:private]).to be_in([true, false])

    expect(response[:data]).to have_key(:relationships)
    expect(response[:data][:relationships]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:user_gardens)
    expect(response[:data][:relationships][:user_gardens]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:users)
    expect(response[:data][:relationships][:users]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:sensors)
    expect(response[:data][:relationships][:sensors]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:garden_plants)
    expect(response[:data][:relationships][:garden_plants]).to be_a(Hash)
  end
end
