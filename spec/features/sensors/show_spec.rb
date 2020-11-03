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
    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/sensors/#{@sensor.id}").to_return(status: 200, body: public_response)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'shows a sensors last 5 readings' do
    visit "/api/v1/sensors/#{@sensor.id}"
  end
end
