require 'rails_helper'

RSpec.describe 'Sensor show page' do
  before :each do
    @garden = { id: 9,
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
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/sensors/1").to_return(status: 200, body: public_response)

    public_response = File.read('spec/fixtures/garden_healths.json')
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/1").to_return(status: 200, body: public_response)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'shows a sensors last 5 readings' do
    params = {id: 1}
    sensor = SensorFacade.sensor_details(params)
    visit "/gardens/9/sensors/1"

    expect(page).to have_content("Your #{sensor.sensor_type} sensor")
    expect(page).to have_content("Last 5 Readings")

    sensor.garden_healths[-5..-1].reverse.each do |reading|
      expect(page).to have_content(reading.reading)
    end
  end

  it 'can search a sensors readings by date' do
    visit "/gardens/9/sensors/1"

    params = {history: 1}
    search_response = File.read('spec/fixtures/search.json')
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/search?start=#{(DateTime.now - params[:history].to_i).to_s[0..9]}&stop=#{DateTime.now.to_s[0..9]}&sensor_id=1").to_return(status: 200, body: search_response)

    click_link 'Last 24 Hours'
    expect(current_path).to eq("/gardens/9/sensors/1")

    params = {history: 7}
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/search?start=#{(DateTime.now - params[:history].to_i).to_s[0..9]}&stop=#{DateTime.now.to_s[0..9]}&sensor_id=1").to_return(status: 200, body: search_response)

    click_link 'Last 7 Days'
    expect(current_path).to eq("/gardens/9/sensors/1")

    params = {history: 14}
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/search?start=#{(DateTime.now - params[:history].to_i).to_s[0..9]}&stop=#{DateTime.now.to_s[0..9]}&sensor_id=1").to_return(status: 200, body: search_response)

    click_link 'Last 14 Days'
    expect(current_path).to eq("/gardens/9/sensors/1")

    params = {history: 30}
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/search?start=#{(DateTime.now - params[:history].to_i).to_s[0..9]}&stop=#{DateTime.now.to_s[0..9]}&sensor_id=1").to_return(status: 200, body: search_response)

    click_link 'Last 30 Days'
    expect(current_path).to eq("/gardens/9/sensors/1")

    params = {history: 90}
    stub_request(:get, "#{ENV['BE_URL']}/api/v1/garden_healths/search?start=#{(DateTime.now - params[:history].to_i).to_s[0..9]}&stop=#{DateTime.now.to_s[0..9]}&sensor_id=1").to_return(status: 200, body: search_response)

    click_link 'Last 90 Days'
    expect(current_path).to eq("/gardens/9/sensors/1")
  end
end

RSpec.describe 'Sensor show page' do
  describe "a visitor" do
    before :each do
      @public_garden = Garden.new({ id: 7,
                attributes: {
                    name: 'Cole Community Garden',
                    latitude: 39.45,
                    longitude: -104.58,
                    description: 'A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.',
                    private: false },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                      data: [{id: "1", type: "user"}]},
                                 sensors: {
                                    data: [{id: "1", type: "sensor"}]}}})
      @user = nil
    end

    it "cannot visit page" do
      visit "/gardens/#{@public_garden.id}/sensors/#{@public_garden.sensors[0][:id]}"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
