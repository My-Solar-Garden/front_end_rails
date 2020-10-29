require 'rails_helper'

RSpec.describe 'Sessions Controller', type: :feature do
    describe "As a visitor" do
        before :each do
            stub_omniauth
            # @user = create(:omniauth_mock_user)
            visit root_path
            click_link 'Login with Google'
        end

        it "I can sign in with Google OAuth" do


        end
    end
end 