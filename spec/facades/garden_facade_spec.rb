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
end
