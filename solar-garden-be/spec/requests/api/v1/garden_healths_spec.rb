require 'rails_helper'

RSpec.describe 'GardenHealth API' do
  describe 'happy-paths' do
    it "sends a list of garden health records" do
      garden = create(:garden).id
      sensor = create(:sensor, :moisture_sensor, garden_id: garden).id
      create_list(:garden_health, 5, sensor_id: sensor)

      get '/api/v1/garden_healths'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      garden_healths = json[:data]

      expect(garden_healths).to be_an(Array)
      expect(garden_healths.size).to eq(5)

      garden_healths.each do |garden_health|
        gh_serializer_check(garden_health)
      end
    end

    it "can get one garden health record by its id" do
      garden = create(:garden).id
      sensor = create(:sensor, :moisture_sensor, garden_id: garden).id
      id = create(:garden_health, sensor_id: sensor).id

      get "/api/v1/garden_healths/#{id}"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      garden_health = json[:data]

      gh_serializer_check(garden_health)
    end

    it "can create a new garden health record" do
      garden = create(:garden).id
      sensor = create(:sensor, :moisture_sensor, garden_id: garden)
      garden_health_params = {
                              sensor_id: sensor.id,
                              reading_type: 0,
                              reading: 123.456
                            }

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/garden_healths", headers: headers, params: JSON.generate(garden_health_params)

      expect(response).to be_successful
      gh = JSON.parse(response.body, symbolize_names: true)
      gh_serializer_check(gh[:data])

      garden_health = GardenHealth.last

      expect(garden_health.sensor_id).to eq(sensor.id)
      expect(garden_health.reading_type).to eq("moisture")
      expect(garden_health.reading).to eq(garden_health_params[:reading])
    end

    it "can update a garden health record" do
      garden = create(:garden).id
      sensor = create(:sensor, :moisture_sensor, garden_id: garden).id
      garden_health = create(:garden_health, sensor_id: sensor)
      previous_reading = garden_health.reading

      garden_health_params = { reading: 10101.101 }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/garden_healths/#{garden_health.id}", headers: headers, params: JSON.generate(garden_health_params)

      garden_health = GardenHealth.find(garden_health.id)
      expect(response).to be_successful
      gh = JSON.parse(response.body, symbolize_names: true)
      gh_serializer_check(gh[:data])

      expect(garden_health.reading).to_not eq(previous_reading)
      expect(garden_health.reading).to eq(garden_health_params[:reading])
    end

    it "can destroy a garden health record" do
      garden = create(:garden).id
      sensor = create(:sensor, :moisture_sensor, garden_id: garden).id
      id = create(:garden_health, sensor_id: sensor).id

      expect{delete "/api/v1/garden_healths/#{id}"}.to change(GardenHealth, :count).by(-1)
      expect(response).to be_successful

      expect{GardenHealth.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    def gh_serializer_check(garden_health)
      expect(garden_health).to have_key(:id)
      expect(garden_health[:id]).to be_a(String)
      expect(garden_health).to have_key(:type)
      expect(garden_health[:type]).to be_a(String)
      expect(garden_health).to have_key(:attributes)
      expect(garden_health[:attributes]).to be_a(Hash)
      expect(garden_health[:attributes]).to have_key(:id)
      expect(garden_health[:attributes][:id]).to be_an(Integer)
      expect(garden_health[:attributes]).to have_key(:reading_type)
      expect(garden_health[:attributes][:reading_type]).to be_a(String)
      expect(garden_health[:attributes]).to have_key(:reading)
      expect(garden_health[:attributes][:reading]).to be_a(Float)
      expect(garden_health[:attributes]).to have_key(:created_at)
      expect(garden_health[:attributes][:created_at]).to be_a(String)
    end
  end

  describe "sad-paths" do
    it "index - return a 204 if no garden_health record exists" do
      get '/api/v1/garden_healths'
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it "show - return a 204 if garden_health record cannot be found" do
      get '/api/v1/garden_healths/99999'
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it "create - return a 204 if wrong params given" do
      post '/api/v1/garden_healths'
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it "update - return a 204 if wrong params given" do
      garden = create(:garden).id
      sensor = create(:sensor, :moisture_sensor, garden_id: garden).id
      id = create(:garden_health, sensor_id: sensor).id
      garden_health_params = { reading: 'a reading cannot be a string' }
      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v1/garden_healths/#{id}", headers: headers, params: JSON.generate(garden_health_params)
      expect(response).to be_successful
      expect(response.status).to eq(204)

      patch "/api/v1/garden_healths/99999"
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it "destroy - return a 204 if garden_health record cannot be found" do
      delete '/api/v1/garden_healths/99999'
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end
end
