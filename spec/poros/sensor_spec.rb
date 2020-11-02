require 'rails_helper'

RSpec.describe Sensor do
  it "exists" do
    attr = {
    "data": {
        "id": "1",
        "type": "sensor",
        "attributes": {
            "min_threshold": 5.0,
            "max_threshold": 14.0,
            "sensor_type": "moisture"
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

    expect(sensor).to be_a(Sensor)
    expect(sensor.id).to be_a(String)
    expect(sensor.id).to eq('1')
    expect(sensor.min_threshold).to be_a(Float)
    expect(sensor.min_threshold).to eq(5.0)
    expect(sensor.max_threshold).to be_a(Float)
    expect(sensor.max_threshold).to eq(14.0)
    expect(sensor.sensor_type).to be_a(String)
    expect(sensor.sensor_type).to eq('moisture')
    expect(sensor.garden_id).to be_a(String)
    expect(sensor.garden_id).to eq('1')
    expect(sensor.garden_healths).to be_a(Array)
    expect(sensor.garden_healths).to eq([])
  end
end
