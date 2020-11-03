require 'rails_helper'

describe GardenHealthFacade do
  it "should return garden_health details for specific garden_health" do
    params = {id: 1}
    garden_health = GardenHealthFacade.garden_health_details(params, 1)

    expect(garden_health).to be_a(GardenHealth)
  end

  it "should generate garden_health poros" do
    params = {:data=>
                    {:id=>"1",
                     :type=>"garden_health",
                     :attributes=>{
                       :id=>1,
                       :reading=>700.0,
                       :reading_type=>"light",
                       created_at: "2020-10-29T22:58:12.265Z",
                     }
                   }
            }
    garden_health = GardenHealthFacade.garden_health(params, 1)
    expect(garden_health).to be_a(GardenHealth)
  end
end
