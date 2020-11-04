require 'rails_helper'

describe SensorFacade do
  it "can generate a new sensor" do
    sensor_params = {sensor_type: 'moisture', min_threshold: 5, max_threshold: 10, garden_id: 1}

    new_sensor = File.read('spec/fixtures/new_sensor.json')

    stub_request(:post, "https://solar-garden-be.herokuapp.com/api/v1/sensors?garden_id=#{sensor_params[:garden_id]}&sensor_type=#{sensor_params[:sensor_type]}&min_threshold=#{sensor_params[:min_threshold]}&max_threshold=#{sensor_params[:max_threshold]}").to_return(status: 200, body: new_sensor, headers: {})

    sensor = SensorFacade.new_sensor(sensor_params)

    expect(sensor).to be_a(Sensor)
  end

  it "can return all sensors belonging to a garden" do
    params = {id: 1}
    sensors = File.read('spec/fixtures/sensors.json')

    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/#{params[:id]}/sensors").to_return(status: 200, body: sensors, headers: {})

    sensors = SensorFacade.all_sensors_for_garden(params)
    expect(sensors).to be_an(Array)
    expect(sensors.all? { |sensor| sensor.class == Sensor }).to be_truthy
  end
end
