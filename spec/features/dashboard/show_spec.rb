require 'rails_helper'

RSpec.describe 'User Dashboard' do
  describe 'a logged in user' do
    before :each do
      user = User.new({id: 1,
                      attributes: { email: '123@gmail.com' },
                      relationships: { gardens: { data: [] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'can visit their dashboard' do
      visit '/gardens'
    end

    it 'sees a CTA to create a new garden if they have none' do
      visit '/gardens'

      expect(page).to have_content('You have no gardens')
      expect(page).to have_button('Add New Garden')
    end
  end

  describe 'a visitor' do
    it 'cannot visit a dashboard' do
      visit '/gardens'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
