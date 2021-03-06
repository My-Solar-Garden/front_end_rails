require 'rails_helper'

describe SensorService do
  it "returns create new sensor response" do
    params = {sensor_type: 'moisture',
    min_threshold: 5,
    max_threshold: 10,
    garden_id: 1}

    new_sensor = File.read('spec/fixtures/new_sensor.json')

    stub_request(:post, "#{ENV['BE_URL']}/api/v1/sensors?garden_id=#{params[:garden_id]}&sensor_type=#{params[:sensor_type]}&min_threshold=#{params[:min_threshold]}&max_threshold=#{params[:max_threshold]}").to_return(status: 200, body: new_sensor, headers: {})

    response = SensorService.new_sensor(params)

    sensor_structure_check(response)
  end

  it "returns all sensors related to a garden" do
    params = {id: 1}
    sensors = File.read('spec/fixtures/sensors.json')

    stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{params[:id]}/sensors").to_return(status: 200, body: sensors, headers: {})

    response = SensorService.all_sensors_for_garden(params)

    expect(response).to be_an(Array)

    response.each do |sensor_data|
      sensor_structure_check(sensor_data)
    end
  end

  xit "deletes a sensor", :vcr do
    garden = {id: 1}
    sensors = SensorService.all_sensors_for_garden(garden)
    total = sensors.size
    params = { id: sensors.first[:id] }
    SensorService.delete_sensor(params)
    new_total = SensorService.all_sensors_for_garden(garden).size
    expect(new_total).to eq(total - 1)
  end

  it "returns an updated sensor response" do
    params = {sensor_type: 'moisture',
    min_threshold: 9,
    max_threshold: 20,
    garden_id: 1}

    edit_sensor = File.read('spec/fixtures/edit_sensor.json')

    stub_request(:patch, "#{ENV['BE_URL']}/api/v1/sensors?garden_id=#{params[:garden_id]}&sensor_type=#{params[:sensor_type]}&min_threshold=#{params[:min_threshold]}&max_threshold=#{params[:max_threshold]}").to_return(status: 200, body: edit_sensor, headers: {})

    response = SensorService.edit_sensor(params)

    sensor_structure_check(response)
  end
end
