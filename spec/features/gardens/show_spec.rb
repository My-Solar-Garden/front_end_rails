require 'rails_helper'

RSpec.describe 'Show Garden Page' do
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
  end

  describe 'a logged in user' do
    before :each do
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
      
      expect(page).to have_content(@garden[:name])
      expect(page).to have_content(@garden[:description])
      expect(page).to have_content(@garden[:latitude])
      expect(page).to have_content(@garden[:longitude])
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

  describe 'as an unauthenticated user' do
    it "can visit a public garden's show page" do
      visit "/gardens/#{@garden[:id]}"

      expect(page).to have_content(@garden[:name])
      expect(page).to have_content(@garden[:description])
      expect(page).to have_content(@garden[:latitude])
      expect(page).to have_content(@garden[:longitude])
    end

    it "cannot visit a private garden's show page" do
      @private_garden = { id: 2,
      attributes: {
          name: 'My Garden Oasis',
          latitude: 66.0,
          longitude: 84.0,
          description: 'Field of Dreams',
          private: true },
      relationships: { plants: {
                          data: []},
                       sensors: {
                          data: []}}}

      visit "/gardens/#{@private_garden[:id]}"

      expect(page.status_code).to eq(404)
    end
  end
end
