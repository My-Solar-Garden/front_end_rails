require 'rails_helper'

describe SensorFacade do
  it "should return sensor details for specific sensor" do
    sensor_params = {sensor_type: 0, min_threshold: 5, max_threshold: 10, garden_id: 1}
    sensor = SensorFacade.new_sensor(sensor_params)
    excpet(SensorFacde.all.count).to eq(1)
  end
end
