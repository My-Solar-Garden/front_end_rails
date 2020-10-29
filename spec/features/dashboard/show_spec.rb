require 'rails_helper'

RSpec.describe 'User Dashboard' do
  describe 'a logged in user' do
    before :each do
      @user = User.new({id: 1,
                      attributes: { email: '123@gmail.com' },
                      relationships: { gardens: { data: [] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'can visit their dashboard' do
      visit '/gardens'
    end

    it 'sees a CTA to create a new garden if they have none' do
      visit '/gardens'
      expect(page).to have_content('You have no gardens')
      expect(page).to have_button('Add New Garden')
    end

    it 'has a button to create a new garden' do
      visit '/gardens'
      click_button('Add New Garden')
      expect(current_path).to eq(new_garden_path)
    end

    it 'displays the users gardens' do
      @user.gardens << {id: 1, type: 'garden'}
      @user.gardens << {id: 2, type: 'garden'}
      visit '/gardens'
      expect(page).to have_css('.garden', count: 2)

      within '#garden-1' do
        expect(page).to have_css('.garden-button', count: 2)
      end

      within '#garden-2' do
        expect(page).to have_css('.garden-button', count: 2)
      end
    end

    it 'has an image to edit and delete a garden' do
      @user.gardens << {id: 1, type: 'garden'}
      visit '/gardens'

      within '#garden-1' do
        find(:xpath, "//a[contains(@alt, 'edit-garden')]").click
      end

      expect(current_path).to eq("/gardens/1/edit")
      visit '/gardens'

      within '#garden-1' do
        find(:xpath, "//a[contains(@alt, 'delete-garden')]").click
      end
      expect(current_path).to eq(gardens_path)

    end
  end

  describe 'a visitor' do
    it 'cannot visit a dashboard' do
      visit '/gardens'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
