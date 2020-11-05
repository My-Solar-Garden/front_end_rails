require 'rails_helper'

RSpec.describe 'User Dashboard' do
  describe 'a logged in user' do
    before :each do
      @user_without_gardens = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [] }}})

      @user_with_gardens = User.new({id: 2,
      attributes: {
        email: 'planter@gmail.com' },
        relationships: {
          gardens: {
            data: [ {id: '3', type: 'garden'}, {id: '4', type: 'garden'}] }}})

      garden1 = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: garden1)

      garden2 = File.read('spec/fixtures/private_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/4").to_return(status: 200, body: garden2)
    end

    it 'can visit their dashboard' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_without_gardens)
      visit dashboard_path
    end

    it 'sees a CTA to create a new garden if they have none' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_without_gardens)
      visit dashboard_path
      expect(page).to have_content('You have no gardens')
      expect(page).to have_button('Add New Garden')
    end

    it 'has a button to create a new garden' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_without_gardens)
      visit dashboard_path
      click_button('Add New Garden')
      expect(current_path).to eq(new_garden_path)
    end

    it 'displays the users gardens' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_gardens)

      visit dashboard_path

      expect(page).to have_css('.garden', count: 2)

      within '#garden-3' do
        expect(page).to have_css('.icon', count: 2)
      end

      within '#garden-4' do
        expect(page).to have_css('.icon', count: 2)
      end
    end

    it 'has an image to edit and delete a garden' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_gardens)

      visit dashboard_path

      within '#garden-3' do
        find('.fa-edit').click
      end

      # edit garden functionality not yet implemented
      # expect(current_path).to eq("/gardens/3/edit")
      visit dashboard_path

      within '#garden-4' do
        find('.fa-trash').click
      end
      expect(current_path).to eq(dashboard_path)
    end

    it "can clink on the garden name to get redirected to the garden show page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_gardens)

      visit dashboard_path

      click_link "The Grove"
      expect(current_path).to eq(garden_path(3))
    end
  end

  describe 'a visitor' do
    it 'cannot visit a dashboard' do
      visit dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
