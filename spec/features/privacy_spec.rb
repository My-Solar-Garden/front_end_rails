require 'rails_helper'

RSpec.describe 'Privacy page', type: :feature do
  describe "As a visitor" do
    it "I can visit the privacy page" do
      visit '/privacy'
      expect(page).to have_content("Welcome")
      expect(page).to have_link("Back to Welcome")
    end
  end
end
