require 'rails_helper'

RSpec.describe 'User profile page' do
  describe 'a visitor' do
    it 'cannot visit a profile page' do
      visit profile_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'a user' do
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

    it 'can visit their profile page' do
      visit profile_path
    end

    it 'displays relevant user information' do
      visit profile_path

      expect(page).to have_content('Your Information')

      expect(page).to have_css('.id')
      id = find('.id').text
      expect(id).to_not be_empty
      expect(page).to have_css('.email')
      email = find('.email').text
      expect(email).to_not be_empty
    end

    it 'has button to update their profile' do
      visit profile_path
      expect(page).to have_button('Update Profile')
      click_button('Update Profile')
      expect(current_path).to eq(edit_user_path(@user.id))
    end

    it 'has button to delete their profile' do
      visit profile_path
      expect(page).to have_button('Delete Profile')
    end
  end
end
