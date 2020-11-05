require 'rails_helper'

RSpec.describe 'New Garden Page' do
  describe 'a visitor' do
    it 'cannot visit new garden page' do
      visit new_garden_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'a logged in user' do
    before :each do
      @user = User.new({id: 1,
                      location: {
                        lat: 39.74,
                        lon: -104.98
                      },
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can visit the create a new garden page' do
      visit new_garden_path
    end

    it 'sees four input fields, two radio buttons and a button to submit' do
      visit new_garden_path
      expect(page).to have_selector("input[placeholder='Tomato Garden']")
      expect(page).to have_selector("input[placeholder='39.7392']")
      expect(page).to have_selector("input[placeholder='104.9903']")
      expect(page).to have_selector("input[id='private_true']")
      expect(page).to have_selector("input[id='private_false']")
      expect(page).to have_button('Create Garden')
    end

    it 'fills new garden form, submits and is redirected to dashboard' do
      name = 'The Grove'
      longitude = 25.0000
      latitude = 71.0000
      description = 'My first garden'

      expected_output = File.read('spec/fixtures/new_garden.json')

      stub_request(:post, "https://solar-garden-be.herokuapp.com/api/v1/gardens?description=#{description}&latitude=#{latitude}&longitude=#{longitude}&name=#{name}&private=false&user_id=#{@user.id}").to_return(status: 200, body: expected_output, headers: {})

      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/50").to_return(status: 200, body: expected_output, headers: {})

      visit new_garden_path
      fill_in :name, with: name
      fill_in :longitude, with: longitude
      fill_in :latitude, with: latitude
      fill_in :description, with: 'My first garden'
      find('#private_false').click

      @user_with_garden = User.new({id: 1,
        location: {
          lat: 39.74,
          lon: -104.98
        },
      attributes: {
        email: '123@gmail.com' },
        relationships: {
          gardens: {
            data: [ {id: '50', type: 'garden'}] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_garden)
      click_button 'Create Garden'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(longitude)
      expect(page).to have_content(latitude)
      expect(page).to have_content(false)
    end
  end
end
