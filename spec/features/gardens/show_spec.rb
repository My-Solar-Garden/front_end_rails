require 'rails_helper'

RSpec.describe 'Show Garden Page' do
  describe 'gardens without plants or sensors' do
    before :each do
      @public_garden = Garden.new({ id: 4,
                attributes: {
                    name: 'Cole Community Garden',
                    latitude: 39.45,
                    longitude: -104.58,
                    description: 'A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.',
                    private: false },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                      data: [{id: "4", type: "user"}]},
                                 sensors: {
                                    data: []}}})

      @private_garden = Garden.new({ id: 3,
                attributes: {
                    name: 'The Grove',
                    latitude: 39.75,
                    longitude: -104.99,
                    description: 'Corner garden',
                    private: true },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                    data: [{id: "1", type: "user"}]},
                                  sensors: {
                                    data: []}}})


      # change to vcr fixture testing eventually (once there's data available to actually call)
      public_response = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{@public_garden.id}").to_return(status: 200, body: public_response)

      private_response = File.read('spec/fixtures/private_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{@private_garden.id}").to_return(status: 200, body: private_response)

      weather_response = File.read('spec/fixtures/weather.json')
      stub_request(:get, "#{ENV['BE_URL']}/a/api/v1/forecast/}").to_return(status: 200, body: weather_response)
    end

    describe 'as a logged in user' do
      before :each do
        @user_mary = User.new({id: 90,
                        attributes: {
                            email: '123@gmail.com' },
                        relationships: {
                            gardens: {
                                data: [ @garden ] }}})

        @garden = @user_mary.gardens.first

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_mary)
      end

      it "can visit a public garden's garden show page" do
        visit "/gardens/#{@public_garden.id}"

        expect(page).to have_content(@public_garden.name)
        expect(page).to have_content(@public_garden.description)
        expect(page).to have_content(@public_garden.latitude)
        expect(page).to have_content(@public_garden.longitude)
      end

      it "cannot visit a private garden's show page that they do not own" do
        visit "/gardens/#{@private_garden.id}"

        expect(page.status_code).to eq(404)
      end

      it "can visit a private garden's show page that they do own" do
        user2 = User.new({id: 3,
                          attributes: {
                              email: 'user@user.com' },
                          relationships: {
                              gardens: {
                                  data: [ @private_garden ] }}})

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

        visit "/gardens/#{@private_garden.id}"

        expect(page).to have_content(@private_garden.name)
        expect(page).to have_content(@private_garden.description)
        expect(page).to have_content(@private_garden.latitude)
        expect(page).to have_content(@private_garden.longitude)
      end

      it 'displays CTA when garden has no plants or sensors' do
        stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{@public_garden.id}/sensors").to_return(status: 200, body: '{"data":[]}')

        visit "/gardens/#{@public_garden.id}"

        within '.garden-plants' do
          expect(page).to have_content('You have no plants')
          expect(page).to have_button('Find Plants')
        end

        within '.garden-sensors' do
          expect(page).to have_content('You have no sensors')
          expect(page).to have_button('Add Sensor')
        end
      end

      xit "expects to see the see an 9 day forcast including today" do
        visit "/gardens/#{@public_garden.id}"

        expect(@weather.temperature).to be_a(Numeric)
        expect(@weather.humidity).to be_a(Numeric)
        expect(@weather.description).to be_a(String)
        expect(@weather.daily).to be_an(Array)
        expect(@weather.daily.first).to be_an(DailyForecast)
        expect(@weather.daily.first.description).to be_a(String)
        expect(@weather.daily.first.humidity).to be_a(Numeric)
        expect(@weather.daily.first.temperature).to be_a(Numeric)
      end
    end

    describe 'as an unauthenticated user' do
      it "can visit a public garden's show page" do
        visit "/gardens/#{@public_garden.id}"

        expect(page).to have_content(@public_garden.name)
        expect(page).to have_content(@public_garden.description)
        expect(page).to have_content(@public_garden.latitude)
        expect(page).to have_content(@public_garden.longitude)
      end

      it "cannot visit a private garden's show page" do
        visit "/gardens/#{@private_garden.id}"

        expect(page.status_code).to eq(404)
      end
    end
  end

  describe 'a logged in user with plants and sensors' do
    before :each do
      @public_garden_2 = Garden.new({ id: 10,
                attributes: {
                    name: 'Cole Community Garden',
                    latitude: 39.45,
                    longitude: -104.58,
                    description: 'A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.',
                    private: false },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                      data: [{id: "4", type: "user"}]},
                                 sensors: {
                                    data: []}}})
      @sensor1 = {:id=> 4,
                  :type=>"sensor",
                  :attributes=>{
                    :min_threshold=>2,
                    :max_threshold=>15,
                    :sensor_type=>"moisture"
                    },
                  :relationships=>{
                    :garden=>{:data=>{:id=> 3, :type=>"garden"}}, :garden_healths=>{:data=>[]}
                    }
                  }

      @sensor2 = {:id=> 5,
                  :type=>"sensor",
                  :attributes=>{
                    :min_threshold=>2,
                    :max_threshold=>15,
                    :sensor_type=>"temperature"
                    },
                  :relationships=>{
                    :garden=>{:data=>{:id=> 3, :type=>"garden"}}, :garden_healths=>{:data=>[]}
                    }
                  }
      @sensor3 = {:id=> 6,
                  :type=>"sensor",
                  :attributes=>{
                    :min_threshold=>2,
                    :max_threshold=>15,
                    :sensor_type=>"light"
                    },
                  :relationships=>{
                    :garden=>{:data=>{:id=> 3, :type=>"garden"}}, :garden_healths=>{:data=>[]}
                    }
                  }
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "displays all sensors related to a garden" do
      json_response = File.read('spec/fixtures/garden_with_sensors.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: json_response)

      sensors = File.read('spec/fixtures/sensors.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3/sensors").to_return(status: 200, body: sensors)

      visit "/gardens/3"

      within '.garden-sensors' do
        expect(page).to have_content(@sensor1[:id])
        expect(page).to have_content(@sensor1[:attributes][:sensor_type])
        expect(page).to have_link(@sensor1[:attributes][:sensor_type])
        expect(page).to have_content(@sensor2[:id])
        expect(page).to have_content(@sensor2[:attributes][:sensor_type])
        expect(page).to have_link(@sensor2[:attributes][:sensor_type])
      end
    end

    it "expects sensor link to link to sensor show page" do
      json_response = File.read('spec/fixtures/garden_with_sensors.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: json_response)


      sensors = File.read('spec/fixtures/sensors.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3/sensors").to_return(status: 200, body: sensors)

      sensor = File.read('spec/fixtures/sensor.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/sensors/#{@sensor1[:id]}").to_return(status: 200, body: sensor)

      visit "/gardens/3"

      click_link @sensor1[:attributes][:sensor_type]

      expect(current_path).to eq("/gardens/1/sensors/#{@sensor1[:id]}")
    end

    it 'can click the Add Sensor button' do
      visit "/gardens/#{@public_garden_2.id}"
      click_on "Add Sensor"
      expect(current_path).to eq("/gardens/#{@public_garden_2.id}/sensors")
    end

    it "displays garden temperature through sensor reading", :vcr do
      user = User.new({id: 10,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit garden_path(248)

      expect(page).to have_content('Current Garden Temperature:')
      expect(page).to have_content('99')
    end

    it "displays garden light percentage through sensor reading", :vcr do
      user = User.new({id: 10,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit garden_path(248)

      expect(page).to have_content('Current Garden Light Percentage:')
      expect(page).to have_content('90.91%')
    end

    it "has search for plants field and add button" do
      json_response = File.read('spec/fixtures/garden_with_sensors.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: json_response)

      visit "/gardens/3"

      expect(page).to have_field('search_term')
      expect(page).to have_button('Find Plants')
    end

    it "displays plants for gardens with plants" do
      json_response = File.read('spec/fixtures/garden_with_plants.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/247").to_return(status: 200, body: json_response)

      json_response = File.read('spec/fixtures/plants.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/247/plants").to_return(status: 200, body: json_response)

      visit "/gardens/247"

      expect(page).to have_content('Carrots')
    end
  end
end
