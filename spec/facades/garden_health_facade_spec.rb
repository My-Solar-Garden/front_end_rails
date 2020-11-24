require 'rails_helper'

describe GardenHealthFacade do
  xit "should return garden_health details for specific garden_health" do
    params = {id: 36}
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
    garden_health = GardenHealthFacade.garden_health(params[:data], 1)
    expect(garden_health).to be_a(GardenHealth)
  end

  xit "returns last reading" do
    attr = {
    "data": {
        "id": "89",
        "type": "sensor",
        "attributes": {
            "min_threshold": 5.0,
            "max_threshold": 14.0,
            "sensor_type": "temperature"
        },
        "relationships": {
            "garden": {
                "data": {
                    "id": "1",
                    "type": "garden"
                }
            },
            "garden_healths": {
                "data": []
            }
        }
    }}

    sensor = Sensor.new(attr.deep_symbolize_keys[:data])

    reading = GardenHealthFacade.last_reading(sensor)

    expect(reading.reading).to eq(25.0)
  end
end
