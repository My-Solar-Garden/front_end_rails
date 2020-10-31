require 'rails_helper'

RSpec.describe 'Sessions Controller', type: :feature do
  describe "As a visitor" do
    VCR.use_cassette('google_oauth') do
      it "I can sign in with Google OAuth" do
        visit root_path
        stub_omniauth
        click_link 'Login with Google'
        expect(page).to have_content('You have successfully logged in')
      end
    end
  end
end
