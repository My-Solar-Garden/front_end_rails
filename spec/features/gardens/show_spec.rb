require 'rails_helper'

RSpec.describe 'Show Garden Page' do
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

    it 'can visit a garden show page' do
      visit "/gardens/#{@garden[:id]}"
    end

    it 'displays CTA when garden has no plants or sensors' do
      visit "/gardens/#{@garden[:id]}"

      within '.garden-plants' do
        expect(page).to have_content('You have no plants')
        expect(page).to have_button('Add Plant')
      end

      within '.garden-sensors' do
        expect(page).to have_content('You have no sensors')
        expect(page).to have_button('Add Sensor')
      end
    end
  end
end
