require 'rails_helper'

RSpec.describe 'Plant Show Page' do
  describe 'user' do
    before :each do
      @garden = { id: 3,
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
                                    data: []}}}
      @user = User.new({id: 4,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "can see plant info for a specific plant" do
      response = File.read('spec/fixtures/plant_show.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/plants/1").
         to_return(status: 200, body: response, headers: {})
      visit gardens_plant_show_path(@garden[:id], @garden[:relationships][:plants][:data].first[:id])
      # visit plant_path(@garden[:relationships][:plants][:data].first[:id])

      expect(page).to have_content("tomato")
      expect(page).to have_content("tomatous redus")
      expect(page).to have_content("the red kind")
      expect(page).to have_content("some")
      expect(page).to have_content("some")
      expect(page).to have_content("fall")
      expect(page).to have_content("spring")
      expect(page).to have_content("bugs")
    end
  end
end
