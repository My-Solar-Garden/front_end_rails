require 'rails_helper'

RSpec.describe 'Edit Garden Page' do
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

    it 'can visit edit a garden page' do
      visit "/gardens/#{@garden[:id]}/edit"
    end

    it 'sees four input fields, two radio buttons and a button to submit' do
      visit "/gardens/#{@garden[:id]}/edit"

      expect(find_field(:name).value).to eq("#{@garden[:attributes][:name]}")
      expect(find_field(:latitude).value).to eq("#{@garden[:attributes][:latitude]}")
      expect(find_field(:longitude).value).to eq("#{@garden[:attributes][:longitude]}")
      expect(page).to have_selector("input[id='private_true']")
      expect(page).to have_selector("input[id='private_false']")
      expect(page).to have_button('Update Garden')
    end

    it 'fills new garden form, submits and is redirected to gardens index' do
      visit "/gardens/#{@garden[:id]}/edit"
      fill_in :name, with: 'Test'
      fill_in :longitude, with: 25.0000
      fill_in :latitude, with: 71.0000
      fill_in :description, with: 'My first garden'
      click_button 'Update Garden'
      expect(current_path).to eq(gardens_path)
    end
  end
end
