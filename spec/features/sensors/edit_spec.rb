require 'rails_helper'

RSpec.describe 'Edit Sensor Page' do
  describe 'a logged in user' do
    before :each do
      @garden = { id: 3,
                attributes: {
                    name: "Cole Community Garden",
                    latitude: 39.45,
                    longitude: -104.58,
                    description: "A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.",
                    private: false },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                    data: [{id: "4", type: "user"}]},
                                 sensors: {
                                    data: []}}}

      @user = User.new({id: 4,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})

      @garden = @user.gardens.first

      @sensor =  { data: {
              id: 3,
              type: "sensor",
              attributes: {
                  min_threshold: 5,
                  max_threshold: 10,
                  sensor_type: 0
              },
              relationships: {
                  garden: {
                      data: {
                          id: 4,
                          type: "garden"
                      }
                  },
                  garden_healths: {
                      data: []
                  }
              }
          }
      }

      garden1 = File.read('spec/fixtures/public_garden.json')
      sensor1 = File.read('spec/fixtures/new_sensor.json')

      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/3/sensors/3").to_return(status: 200, body: garden1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can visit edit a sensor page and see 3 input fileds and a submit button' do
      visit "/gardens/#{@garden[:id]}/sensors/#{@sensor[:data][:id]}/edit"
      expect(page).to have_select(:sensor_type)
      expect(page).to have_field('Min threshold')
      expect(page).to have_field('Max threshold')
      expect(page).to have_button('Update Sensor')
    end

    xit 'fills in edit sensor form, submits and is redirected to garden show page' do
      min = 9
      max = 20

      visit "/gardens/#{@garden[:id]}/sensors/#{@sensor[:data][:id]}/edit"
      fill_in :min_threshold, with: min
      fill_in :max_threshold, with: max

      updated_sensor = File.read('spec/fixtures/edit_sensor.json')

      stub_request(:patch, "https://solar-garden-be.herokuapp.com/api/v1/sensors?garden_id=#{@garden[:id]}&sensor_type=moisture&min_threshold=#{min}&max_threshold=#{max}").to_return(status: 200, body: updated_sensor, headers: {})

      click_button 'Update Sensor'
      expect(current_path).to eq("/gardens/#{@garden[:id]}")
    end

    xit 'has a link to edit sensor on sensor show page' do
      visit "/gardens/#{@garden[:id]}/sensors/#{@sensor[:data][:id]}"
      expect(page).to have_link("Edit Sensor")
    end
  end
end
