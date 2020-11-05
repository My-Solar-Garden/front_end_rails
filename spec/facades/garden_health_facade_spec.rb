require 'rails_helper'

describe GardenHealthFacade do
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

    reading = GardenHealthFacade.last_reading(sensor)

    expect(reading).to eq('99')
  end
end
