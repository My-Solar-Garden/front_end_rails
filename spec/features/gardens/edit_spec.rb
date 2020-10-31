require 'rails_helper'

RSpec.describe 'Edit Garden Page' do
  describe 'a logged in user' do
    before :each do
      @garden = { id: 1,
                attributes: {
                    name: 'My Garden',
                    latitude: 23.0,
                    longitude: 24.0,
                    description: 'Simple Garden',
                    private: false },
                relationships: { plants: {
                                    data: []},
                                 sensors: {
                                    data: []}}}

      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})

      @garden = @user.gardens.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can visit edit a garden page' do
      visit "/gardens/#{@garden[:id]}/edit"
    end

    it 'sees four input fields, two radio buttons and a button to submit' do
      visit "/gardens/#{@garden[:id]}/edit"
      expect(page).to have_selector("input[value='#{@garden[:attributes][:name]}']")
      expect(page).to have_selector("input[value='#{@garden[:attributes][:latitude]}']")
      expect(page).to have_selector("input[value='#{@garden[:attributes][:longitude]}']")
      expect(page).to have_selector("input[id='private_true']")
      expect(page).to have_selector("input[id='private_false']")
      expect(page).to have_button('Update Garden')
    end

    it 'fills new garden form, submits and is redirect back to dashboard' do
      visit "/gardens/#{@garden[:id]}/edit"
      fill_in :name, with: 'Test'
      fill_in :longitude, with: 25.0000
      fill_in :latitude, with: 71.0000
      fill_in :description, with: 'My first garden'
      click_button 'Update Garden'
      expect(current_path).to eq(dashboard_path)
    end
  end
end