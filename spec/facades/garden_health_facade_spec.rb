require 'rails_helper'

describe GardenHealthFacade do
  it "should return garden_health details for specific garden_health" do
    params = {id: 36}
    expected_output = File.read('spec/fixtures/garden_healths.json')
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/36").to_return(status: 200, body: expected_output, headers: {})
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

  it "returns last reading" do
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

    expected_output = File.read('spec/fixtures/garden_health_last.json')
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/sensors/89/garden_healths/last").to_return(status: 200, body: expected_output, headers: {})

    reading = GardenHealthFacade.last_reading(sensor)

    expect(reading.reading).to eq(25)
  end
end
