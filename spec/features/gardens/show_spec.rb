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
                    longitude: -104.996577,
                    description: 'Corner garden',
                    private: true },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                    data: [{id: "3", type: "user"}]},
                                  sensors: {
                                    data: []}}})


      # change to vcr fixture testing eventually (once there's data available to actually call)
      public_response = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{@public_garden.id}").to_return(status: 200, body: public_response)

      private_response = File.read('spec/fixtures/private_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{@private_garden.id}").to_return(status: 200, body: private_response)
    end

    describe 'as a logged in user' do
      before :each do
        @user = User.new({id: 1,
                        attributes: {
                            email: '123@gmail.com' },
                        relationships: {
                            gardens: {
                                data: [ @garden ] }}})

        @garden = @user.gardens.first

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it "can visit a public garden's garden show page" do
        visit "/gardens/#{@public_garden.id}"

        expect(page).to have_content(@public_garden.name)
        expect(page).to have_content(@public_garden.description)
        expect(page).to have_content(@public_garden.latitude)
        expect(page).to have_content(@public_garden.longitude)
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

      it "cannot visit a private garden's show page that they do not own" do
        visit "/gardens/#{@private_garden.id}"

        expect(page.status_code).to eq(404)
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

      visit "/gardens/3"

      click_link @sensor1[:attributes][:sensor_type]

      expect(current_path).to eq("/sensors/#{@sensor1[:id]}")
    end

    it 'can click the Add Sensor button' do
      visit "/gardens/3"
      click_on "Add Sensor"
      expect(current_path).to eq("/gardens/3/sensors")
    end

    it "has search for plants field and add button" do
      json_response = File.read('spec/fixtures/garden_with_sensors.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: json_response)

      visit "/gardens/3"

      expect(page).to have_field('search_term')
      expect(page).to have_button('Find Plants')
    end
  end

  describe "A user living in Denver" do
    before :each do
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ ] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      data = {
        "lat": 39.74,
        "lon": -104.98,
        "timezone": "America/Denver",
        "timezone_offset": -25200,
        "current": {
            "dt": 1604356053,
            "sunrise": 1604323817,
            "sunset": 1604361396,
            "temp": 75.31,
            "feels_like": 66.88,
            "pressure": 1026,
            "humidity": 8,
            "dew_point": 12.36,
            "uvi": 3.43,
            "clouds": 20,
            "visibility": 10000,
            "wind_speed": 4.7,
            "wind_deg": 110,
            "weather": [
                {
                    "id": 801,
                    "main": "Clouds",
                    "description": "few clouds",
                    "icon": "02d"
                }
            ]
        },
        "daily": [
            {
                "dt": 1604340000,
                "sunrise": 1604323817,
                "sunset": 1604361396,
                "temp": {
                    "day": 64.58,
                    "min": 49.3,
                    "max": 75.31,
                    "night": 56.82,
                    "eve": 69.53,
                    "morn": 49.3
                },
                "feels_like": {
                    "day": 58.87,
                    "night": 50.76,
                    "eve": 63.18,
                    "morn": 42.85
                },
                "pressure": 1026,
                "humidity": 23,
                "dew_point": 10.81,
                "wind_speed": 2.37,
                "wind_deg": 159,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 0,
                "pop": 0,
                "uvi": 3.43
            },
            {
                "dt": 1604426400,
                "sunrise": 1604410285,
                "sunset": 1604447729,
                "temp": {
                    "day": 67.01,
                    "min": 52.32,
                    "max": 71.4,
                    "night": 58.14,
                    "eve": 65.05,
                    "morn": 52.32
                },
                "feels_like": {
                    "day": 62.53,
                    "night": 51.87,
                    "eve": 59.31,
                    "morn": 45.91
                },
                "pressure": 1018,
                "humidity": 23,
                "dew_point": 17.49,
                "wind_speed": 0.65,
                "wind_deg": 127,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 8,
                "pop": 0,
                "uvi": 3.22
            },
            {
                "dt": 1604512800,
                "sunrise": 1604496754,
                "sunset": 1604534064,
                "temp": {
                    "day": 68.77,
                    "min": 55.06,
                    "max": 73,
                    "night": 58.71,
                    "eve": 66.83,
                    "morn": 55.06
                },
                "feels_like": {
                    "day": 63.97,
                    "night": 51.35,
                    "eve": 56.66,
                    "morn": 48.45
                },
                "pressure": 1020,
                "humidity": 24,
                "dew_point": 29.21,
                "wind_speed": 1.81,
                "wind_deg": 209,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 0,
                "pop": 0,
                "uvi": 3.24
            },
            {
                "dt": 1604599200,
                "sunrise": 1604583223,
                "sunset": 1604620400,
                "temp": {
                    "day": 67.06,
                    "min": 54.12,
                    "max": 72.45,
                    "night": 57.97,
                    "eve": 66.85,
                    "morn": 54.12
                },
                "feels_like": {
                    "day": 61.11,
                    "night": 52,
                    "eve": 61.2,
                    "morn": 48.33
                },
                "pressure": 1022,
                "humidity": 25,
                "dew_point": 26.1,
                "wind_speed": 3.74,
                "wind_deg": 182,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 0,
                "pop": 0,
                "uvi": 3.33
            },
            {
                "dt": 1604685600,
                "sunrise": 1604669693,
                "sunset": 1604706738,
                "temp": {
                    "day": 68.77,
                    "min": 53.46,
                    "max": 73.15,
                    "night": 61.11,
                    "eve": 67.82,
                    "morn": 53.46
                },
                "feels_like": {
                    "day": 57.7,
                    "night": 47.73,
                    "eve": 58.05,
                    "morn": 47.26
                },
                "pressure": 1002,
                "humidity": 23,
                "dew_point": 22.89,
                "wind_speed": 12.68,
                "wind_deg": 182,
                "weather": [
                    {
                        "id": 801,
                        "main": "Clouds",
                        "description": "few clouds",
                        "icon": "02d"
                    }
                ],
                "clouds": 14,
                "pop": 0,
                "uvi": 3.1
            },
            {
                "dt": 1604772000,
                "sunrise": 1604756162,
                "sunset": 1604793077,
                "temp": {
                    "day": 66.06,
                    "min": 40.91,
                    "max": 67.46,
                    "night": 40.91,
                    "eve": 59.05,
                    "morn": 55.96
                },
                "feels_like": {
                    "day": 48.11,
                    "night": 29.71,
                    "eve": 43.3,
                    "morn": 45.45
                },
                "pressure": 988,
                "humidity": 24,
                "dew_point": 20.23,
                "wind_speed": 24.58,
                "wind_deg": 193,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 0,
                "pop": 0.15,
                "uvi": 3.11
            },
            {
                "dt": 1604858400,
                "sunrise": 1604842631,
                "sunset": 1604879418,
                "temp": {
                    "day": 43.99,
                    "min": 22.98,
                    "max": 49.41,
                    "night": 22.98,
                    "eve": 46.67,
                    "morn": 37.44
                },
                "feels_like": {
                    "day": 36,
                    "night": 11.61,
                    "eve": 37,
                    "morn": 27.86
                },
                "pressure": 1012,
                "humidity": 36,
                "dew_point": -7.98,
                "wind_speed": 5.12,
                "wind_deg": 116,
                "weather": [
                    {
                        "id": 800,
                        "main": "Clear",
                        "description": "clear sky",
                        "icon": "01d"
                    }
                ],
                "clouds": 1,
                "pop": 0,
                "uvi": 3.01
            },
            {
                "dt": 1604944800,
                "sunrise": 1604929101,
                "sunset": 1604965761,
                "temp": {
                    "day": 20.62,
                    "min": 16.63,
                    "max": 22.68,
                    "night": 19.45,
                    "eve": 21.22,
                    "morn": 17.04
                },
                "feels_like": {
                    "day": 12.13,
                    "night": 11.16,
                    "eve": 12.88,
                    "morn": 7.18
                },
                "pressure": 1027,
                "humidity": 85,
                "dew_point": 8.8,
                "wind_speed": 5.7,
                "wind_deg": 70,
                "weather": [
                    {
                        "id": 601,
                        "main": "Snow",
                        "description": "snow",
                        "icon": "13d"
                    }
                ],
                "clouds": 100,
                "pop": 0.96,
                "snow": 3,
                "uvi": 2.34
            }
        ]
    }

      @weather = Weather.new(data)
    end

    it "expects to see the see an 8 day forcast" do
      visit dashboard_path

      expect(page).to have_content("Forcast: clear sky")
      expect(page).to have_content("Forcast: few clouds")
      expect(page).to have_content("Forcast: sno")
      expect(page).to have_content("Humidity: 23")
      expect(page).to have_content("Humidity: 24")
      expect(page).to have_content("Humidity: 25")
      expect(page).to have_content("Humidity: 36")
      expect(page).to have_content("Humidity: 85")
      expect(page).to have_content("Temperature: 64.58")
      expect(page).to have_content("Temperature: 67.01")
      expect(page).to have_content("Temperature: 68.77")
      expect(page).to have_content("Temperature: 67.06")
      expect(page).to have_content("Temperature: 68.77")
      expect(page).to have_content("Temperature: 66.06")
      expect(page).to have_content("Temperature: 43.99")
      expect(page).to have_content("Temperature: 20.62")
    end
  end
end
