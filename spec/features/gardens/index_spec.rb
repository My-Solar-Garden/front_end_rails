require 'rails_helper'

RSpec.describe 'Index Page' do
  describe 'a visitor' do
    before :each do
      @garden = { id: 3,
                attributes: {
                    name: "Cole Community Garden",
                    latitude: 39.45,
                    longitude: -104.58,
                    description: "A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.",
                    private: false },
                relationships: { plants: {
                                    data: []},
                                  users: {
                                    data: [{id: "4", type: "user"}]},
                                 sensors: {
                                    data: []}}}
    end

    # it 'can visit public gardens page' do
    #   visit gardens_path
    #   expect(page).to have_content("Public Gardens")
    # end
  end

  describe 'a logged in user' do
    before :each do
      @garden = { id: 3,
                attributes: {
                    name: "Cole Community Garden",
                    latitude: 39.45,
                    longitude: -104.58,
                    description: "A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.",
                    private: false },
                relationships: { plants: {
                                    data: []},
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

      garden1 = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/3").to_return(status: 200, body: garden1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
  end
end
