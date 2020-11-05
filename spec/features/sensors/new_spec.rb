require 'rails_helper'

RSpec.describe 'New Sensor Page' do
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
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @public_garden ] }}})

      @garden = @user.gardens.first
    end

    it "cannot visit page" do
      visit "/gardens/#{@garden.id}/sensors"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'a logged in user' do
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
                                    data: []}}})
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @public_garden ] }}})

      @garden = @user.gardens.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'has fields to add new sensor' do
      visit "/gardens/#{@garden.id}/sensors"
      expect(page).to have_select(:sensor_type)
      expect(page).to have_field('Min threshold')
      expect(page).to have_field('Max threshold')
      expect(page).to have_button('Create Sensor')
    end

    it 'can fill in the fields and create a sensor', :vcr do
      sensor_type = 'moisture'
      min = 5
      max = 10

      visit "/gardens/#{@garden.id}/sensors"

      select sensor_type, from: :sensor_type
      fill_in :min_threshold, with: min
      fill_in :max_threshold, with: max

      click_button 'Create Sensor'
      expect(current_path).to eq("/gardens/#{@garden.id}")

      visit "/gardens/#{@garden.id}"
      expect(page.all(".sensor").size).to eq(6)
    end
  end
end
