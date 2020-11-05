require 'rails_helper'

RSpec.describe 'Remove a plant from a garden' do
  describe 'As a logged in user' do
    before :each do
      @plant = Plant.new({ id: 1,
              attributes: {
                image: "url",
                name: "name",
                species: "species",
                description: "description",
                light_requirements: "alot",
                water_requirements: "medium",
                when_to_plant: "spring",
                harvest_time: "now",
                common_pests: "beetles"}})

      @garden = Garden.new({ id: 3,
                attributes: {
                    name: "Cole Community Garden",
                    latitude: 39.45,
                    longitude: -104.58,
                    description: "A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.",
                    private: false },
                relationships: { plants: {
                                    data: [{id: "1", type: "plant"}]},
                                  users: {
                                    data: [{id: "4", type: "user"}]},
                                 sensors: {
                                   data: []}}})

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
      visit "/gardens/#{@garden.id}/plants/#{@plant.id}"

      expect(page).to have_content(@plant.name)
      expect(page).to have_button('Remove This Plant From Your Garden')
    end
  end
end
