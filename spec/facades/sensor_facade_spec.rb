require 'rails_helper'

describe SensorFacade do
  it "should return sensor details for specific sensor" do
    params = {id: 1}
    sensor = SensorFacade.sensor_details(params)

    expect(sensor).to be_a(Sensor)
  end

  it "should generate sensor poros" do
    params = {:data=>
                    {:id=>"1",
                     :type=>"sensor",
                     :attributes=>{
                       :min_threshold=>1,
                       :max_threshold=>4,
                       :sensor_type=>"light",
                     :relationships=>{
                       :garden=>{
                         :data=>[]},
                         :garden_healths=>{
                           :data=>[]}}}}
            }
    sensor = SensorFacade.sensor_details(params)
    expect(sensor).to be_a(Sensor)
  end
end
