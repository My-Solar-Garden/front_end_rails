require 'rails_helper'

RSpec.describe 'Home Page', type: :feature do
    describe "As a visitor" do
        it "I can see the welcome page" do
            visit '/'
            expect(page).to have_content("Welcome")
        end

        it "I can see a Login with Google link" do
            visit root_path
            expect(page).to have_link("Login with Google")
        end
    end
end 