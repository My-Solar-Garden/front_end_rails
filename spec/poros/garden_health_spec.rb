require 'rails_helper'

describe GardenHealth do
  it "exists" do
    data = {:id=>"57", :type=>"garden_health", :attributes=>{:id=>57, :reading_type=>'temperature', :reading=>99.0, :created_at=>"2020-11-04T00:00:00.000Z"}}
    garden_health = GardenHealth.new(data)

    expect(garden_health).to be_a(GardenHealth)
    expect(garden_health.id).to be_a(Integer)
    expect(garden_health.reading_type).to be_a(String)
    expect(garden_health.reading).to be_a(Float)
    expect(garden_health.created_at).to be_a(String)
  end
end
