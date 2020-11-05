require 'rails_helper'

RSpec.describe 'Remove a plant from a garden' do
  describe 'As a logged in user' do
    before :each do
      @garden = { id: 3,
                attributes: {
                    name: "Cole Community Garden",
                    latitude: 39.45,
                    longitude: -104.58,
                    description: "A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.",
                    private: false },
                relationships: { plants: {
                                    data: [{id: "1", type: "plant"}, {id: "2", type: "plant"}]},
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I can delete a plant from my garden' do
      response = File.read('spec/fixtures/plant_show.json')
      plant = JSON.parse(response, symbolize_names: true)

      stub_request(:get, "#{ENV['BE_URL']}/api/v1/plants/1").
         to_return(status: 200, body: response, headers: {})
      visit gardens_plant_show_path(@garden[:id], @garden[:relationships][:plants][:data].first[:id])

      expect(page).to have_content(plant[:data][:attributes][:name])
      expect(page).to have_button('Remove This Plant From Your Garden')
      click_on 'Remove This Plant From Your Garden'
      expect(current_path).to eq(garden_path("#{@garden[:id]}"))
    end
  end
end
