require 'rails_helper'

RSpec.describe 'Edit Garden Page' do
  describe 'a logged in user' do
    before :each do
      @garden = { id: 4,
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
                              data: [ {id: "4", type: "garden"} ] }}})

      garden1 = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/#{@garden[:id]}").to_return(status: 200, body: garden1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can visit edit a garden page from dashboard' do
      visit dashboard_path

      # it seems like this syntax isn't actually clicking the edit icon
      find('.fa-edit').click

      expect(current_path).to eq("/gardens/#{@garden[:id]}/edit")
    end

    it 'can visit edit a garden page from garden show' do
      visit garden_show_path(@garden[:id])

      find('.fa-edit').click

      expect(current_path).to eq("/gardens/#{@garden[:id]}/edit")
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

    it 'fills in edit garden form, submits and is redirected to garden show page' do
      visit "/gardens/#{@garden[:id]}/edit"

      fill_in :name, with: 'Denver Community Garden'

      garden1 = File.read('spec/fixtures/updated_garden.json')
      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/#{@garden[:id]}").to_return(status: 200, body: garden1)

      click_button 'Update Garden'

      expect(current_path).to eq(garden_show_path(@garden[:id]))

      expect(page).to have_content("Denver Community Garden")
      expect(page).to_not have_content("Cole Community Garden")
    end
  end
end
