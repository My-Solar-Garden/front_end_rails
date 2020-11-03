require 'rails_helper'

RSpec.describe 'Sensor show page' do
  before :each do
    @garden = { id: 1,
              attributes: {
                  name: 'My Garden',
                  latitude: 23.0,
                  longitude: 24.0,
                  description: 'Simple Garden',
                  private: false },
              relationships: { plants: {
                                  data: []},
                                users: {
                                  data: [{id: "1", type: "user"}]},
                               sensors: {
                                  data: []}}}

    @user = User.new({id: 1,
                    attributes: {
                        email: '123@gmail.com' },
                    relationships: {
                        gardens: {
                            data: [ @garden ] }}})

    @garden = @user.gardens.first

    public_response = File.read('spec/fixtures/sensors_with_readings.json')
    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/sensors/1").to_return(status: 200, body: public_response)
    public_response = File.read('spec/fixtures/garden_healths.json')
    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/garden_healths/1").to_return(status: 200, body: public_response)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'shows a sensors last 5 readings' do
    visit "/sensors/1"
  end

  it 'can search a sensors readings by date' do
    params = {:data=>
                    {:id=>"1",
                     :type=>"garden_health",
                     :attributes=>{
                       :id=>1,
                       :reading=>700.0,
                       :reading_type=>"light",
                       created_at: "2020-10-29",
                     }
                   }
            }
    garden_health = GardenHealthFacade.garden_health(params, 1)
    params = {:data=>
                    {:id=>"1",
                     :type=>"sensor",
                     :attributes=>{
                       :min_threshold=>1,
                       :max_threshold=>4,
                       :sensor_type=>"light",
                     :relationships=>{
                       :garden=>{
                         :data=>[id: 1]},
                         :garden_healths=>{
                           :data=>[]}}}}
            }
    sensor = SensorFacade.sensor(params)
    visit "/sensors/1/garden_healths/search?start=2020-10-10&end=2020-10-30&sensor_id=1"
  end
end
