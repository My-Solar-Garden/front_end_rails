require 'rails_helper'

RSpec.describe 'On the garden show page' do
  describe "as a logged in user" do
    before :each do
      @user_with_gardens = User.new({id: 2,
      attributes: {
        email: 'planter@gmail.com' },
        relationships: {
          gardens: {
            data: [ {id: '1', type: 'garden'}] }}})

      Sensor.new({
                    id: "1",
                    type: "sensor",
                    attributes: {
                        min_threshold: 5,
                        max_threshold: 15,
                        sensor_type: "moisture"
                    },
                    relationships: {
                        garden: {
                            data: {
                                id: "1",
                                type: "garden"
                            }
                        },
                        garden_healths: {
                            data: []
                        }
                    }
                })

      new_garden = File.read('spec/fixtures/new_garden.json')
      sensor = File.read('spec/fixtures/sensor.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/43").to_return(status: 200, body: new_garden, headers: {})
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/sensors/1").to_return(status: 200, body: sensor, headers: {})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_gardens)
    end

    xit "I can delete a sensor", :vcr do
      visit garden_path(4)

      sensors = page.all('.garden-sensors') # I tried to change this to garden-sensors from the gardens show.html.erb line 41
      total = sensors.size

      first('.garden-sensors').click_on('Delete') # Error: Capybara::ElementNotFound:
       # Unable to find link or button "Delete" within #<Capybara::Node::Element tag="section" path="/html/body/div[3]/div/div/article/section[3]"

      expect(current_path).to eq(garden_path(4))
      expect(page.all('.garden-sensors').size).to eq(total - 1)
    end
  end
end
