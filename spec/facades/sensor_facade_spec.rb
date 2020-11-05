require 'rails_helper'

describe SensorFacade do
  it "can generate a new sensor" do
    sensor_params = {sensor_type: 'moisture', min_threshold: 5, max_threshold: 10, garden_id: 1}

    new_sensor = File.read('spec/fixtures/new_sensor.json')

    stub_request(:post, "#{ENV['BE_URL']}/api/v1/sensors?garden_id=#{sensor_params[:garden_id]}&sensor_type=#{sensor_params[:sensor_type]}&min_threshold=#{sensor_params[:min_threshold]}&max_threshold=#{sensor_params[:max_threshold]}").to_return(status: 200, body: new_sensor, headers: {})

    sensor = SensorFacade.new_sensor(sensor_params)
  end

  it "should return sensor details for specific sensor" do
    params = {id: 1}
    sensor = File.read('spec/fixtures/sensor.json')

    stub_request(:get, "#{ENV['BE_URL']}/api/v1/sensors/#{params[:id]}").to_return(status: 200, body: sensor, headers: {})

    sensor = SensorFacade.sensor_details(params)
    expect(sensor).to be_a(Sensor)
  end

  it "can return all sensors belonging to a garden" do
    params = {id: 1}
    sensors = File.read('spec/fixtures/sensors.json')

    stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{params[:id]}/sensors").to_return(status: 200, body: sensors, headers: {})

    sensors = SensorFacade.all_sensors_for_garden(params)
    expect(sensors).to be_an(Array)
    expect(sensors.all? { |sensor| sensor.class == Sensor }).to be_truthy
  end

  it "should generate sensor poros" do
    params = {:data=>
                    {:id=>"1",
                     :type=>"sensor",
                     :attributes=>{
                       :min_threshold=>1,
                       :max_threshold=>4,
                       :sensor_type=>"light"
                     },
                     :relationships=>{
                       :garden=>{
                         :data=>{id: 1}},
                         :garden_healths=>{
                           :data=>[]}}}
            }
    sensor = SensorFacade.sensor(params[:data])

    expect(sensor).to be_a(Sensor)
  end

  it "can delete a sensor", :vcr do
    garden = {id: 1}
    sensors = SensorFacade.all_sensors_for_garden(garden)
    total = sensors.size
    params = { id: sensors.first.id }
    SensorFacade.delete_sensor(params)
    new_total = SensorFacade.all_sensors_for_garden(garden).size
    expect(new_total).to eq(total - 1)
  end
end
