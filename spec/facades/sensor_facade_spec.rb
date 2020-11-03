require 'rails_helper'

describe SensorFacade do
  it "can generate a new sensor" do
    sensor_params = {sensor_type: 'moisture', min_threshold: 5, max_threshold: 10, garden_id: 1}

    new_sensor = File.read('spec/fixtures/new_sensor.json')

    stub_request(:post, "https://solar-garden-be.herokuapp.com/api/v1/sensors?garden_id=#{sensor_params[:garden_id]}&sensor_type=#{sensor_params[:sensor_type]}&min_threshold=#{sensor_params[:min_threshold]}&max_threshold=#{sensor_params[:max_threshold]}").to_return(status: 200, body: new_sensor, headers: {})

    sensor = SensorFacade.new_sensor(sensor_params)

    expect(sensor).to be_a(Sensor)
  end
end
