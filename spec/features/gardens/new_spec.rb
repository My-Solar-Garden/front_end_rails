require 'rails_helper'

RSpec.describe 'New Garden Page' do
  describe 'a logged in user' do
    before :each do
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ { id: 1,
                                        attributes: {
                                            name: 'My Garden',
                                            latitude: 23.0,
                                            longitude: 24.0,
                                            description: 'Simple Garden',
                                            private: false }} ] }}})

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

    it 'fills new garden form, submits and is redirect back to dashboard' do
      visit new_garden_path
      fill_in :name, with: 'Test'
      fill_in :longitude, with: 25.0000
      fill_in :latitude, with: 71.0000
      fill_in :description, with: 'My first garden'
      click_button 'Create Garden'
      expect(current_path).to eq(dashboard_path)
    end
  end
end
