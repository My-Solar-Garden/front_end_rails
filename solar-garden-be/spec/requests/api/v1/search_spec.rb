require "rails_helper"

RSpec.describe "search endpoint" do
  before :each do
    @user = create :user
    @garden = create(:garden)
    @user_garden = create(:user_garden, user_id: @user.id, garden_id: @garden.id)
    @light_sensor = create(:sensor, :light_sensor, garden_id: @garden.id)
  end
  describe 'happy path' do
    it 'searches a specific sensors readings between two dates' do
      start_time = DateTime.now.to_s
      searched_readings = create_list(:garden_health, 5, sensor_id: @light_sensor.id, reading_type: 1)
      sleep(1)
      stop_time = DateTime.now.to_s

      irrelevant_readings = create_list(:garden_health, 5, sensor_id: @light_sensor.id, reading_type: 1)

      get "/api/v1/garden_healths/search?start=#{start_time}&stop=#{stop_time}&sensor_id=#{@light_sensor.id}"

      expect(response).to be_successful

      found_readings = JSON.parse(response.body, symbolize_names: true)

      found_readings[:data].each_with_index do |reading, index|
        expect(reading[:attributes][:id]).to eq(searched_readings[index].id)
        expect(reading[:attributes][:reading_type]).to eq(searched_readings[index].reading_type)
        expect(reading[:attributes][:reading]).to eq(searched_readings[index].reading)
        expect(reading[:attributes][:created_at].to_date).to eq(searched_readings[index].created_at.to_date)
      end
    end
  end
  describe 'sad path' do
    it 'cannot search a specific sensors readings if a parameter is not given' do
      start_time = DateTime.now.to_s
      stop_time = DateTime.now.to_s

      get "/api/v1/garden_healths/search?start=#{start_time}&stop=#{stop_time}"
      expect(response.body).to eq("")

      get "/api/v1/garden_healths/search?start=#{start_time}&sensor_id=#{@light_sensor.id}"
      expect(response.body).to eq("")

      get "/api/v1/garden_healths/search?stop=#{stop_time}&sensor_id=#{@light_sensor.id}"
      expect(response.body).to eq("")
    end
  end
end
