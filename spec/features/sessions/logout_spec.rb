require 'rails_helper'

RSpec.describe 'Sessions Controller', type: :feature do
  describe "As a logged in user" do
    it "I can log out" do
      VCR.use_cassette('google_oauth') do
        visit root_path
        stub_omniauth
        click_link 'Login with Google'

        click_link 'Logout'

        expect(page).to have_content("You've made an impact today. We hope to see you again tomorrow.")
      end
    end
  end
end
