require 'rails_helper'

describe GardenHealthService do
  xit "returns the last reading", :vcr do
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

    reading = GardenHealthService.last_reading(sensor)
    expect(reading[:attributes][:reading]).to eq(25.0)
  end
end
