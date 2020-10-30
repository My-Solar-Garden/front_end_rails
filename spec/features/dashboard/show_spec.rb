require 'rails_helper'

RSpec.describe 'User Dashboard' do
  describe 'a logged in user' do
    before :each do
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can visit their dashboard' do
      visit dashboard_path
    end

    it 'sees a CTA to create a new garden if they have none' do
      visit dashboard_path
      expect(page).to have_content('You have no gardens')
      expect(page).to have_button('Add New Garden')
    end

    it 'has a button to create a new garden' do
      visit dashboard_path
      click_button('Add New Garden')
      expect(current_path).to eq(new_garden_path)
    end

    it 'displays the users gardens' do
      @user.gardens << {id: 1,
                        type: 'garden',
                        attributes: {
                            name: 'My Garden',
                            latitude: 23.0,
                            longitude: 24.0,
                            description: 'Simple Garden',
                            private: false }}
      @user.gardens << {id: 2,
                        type: 'garden',
                        attributes: {
                            name: 'My Garden',
                            latitude: 23.0,
                            longitude: 24.0,
                            description: 'Simple Garden',
                            private: false }}
      visit dashboard_path
      
      expect(page).to have_css('.garden', count: 2)

      within '#garden-1' do
        expect(page).to have_css('.garden-button', count: 2)
      end

      within '#garden-2' do
        expect(page).to have_css('.garden-button', count: 2)
      end
    end

    it 'has an image to edit and delete a garden' do
      @user.gardens << {id: 1,
                        type: 'garden',
                        attributes: {
                            name: 'My Garden',
                            latitude: 23.0,
                            longitude: 24.0,
                            description: 'Simple Garden',
                            private: false }}
      visit dashboard_path

      within '#garden-1' do
        find(:xpath, "//a[contains(@alt, 'edit-garden')]").click
      end

      expect(current_path).to eq("/gardens/1/edit")
      visit dashboard_path

      within '#garden-1' do
        find(:xpath, "//a[contains(@alt, 'delete-garden')]").click
      end
      expect(current_path).to eq(dashboard_path)

    end
  end

  describe 'a visitor' do
    it 'cannot visit a dashboard' do
      visit dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
