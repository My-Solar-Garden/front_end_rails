require 'rails_helper'

RSpec.describe 'Sessions Controller', type: :feature do
    describe "As a visitor" do
        it "I can sign in with Google OAuth" do
            allow_any_instance_of(SessionsController).to receive(:auth_hash).and_return(stub_omniauth)
            visit root_path
            click_link 'Login with Google'
            expect(page).to have_content('You have successfully logged in.')
        end

        it "I fail to sign in with Google OAuth" do
            visit root_path
            click_link 'Login with Google'
            expect(page).to have_content('Google Authorization was unable to be completed.')
        end
    end
end 