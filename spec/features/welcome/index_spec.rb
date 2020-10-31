require 'rails_helper'

RSpec.describe 'Welcome' do
  describe 'a visitor' do
    before :each do
      @garden = { id: 1,
                attributes: {
                    name: 'My Garden',
                    latitude: 23.0,
                    longitude: 24.0,
                    description: 'Simple Garden',
                    private: false },
                relationships: { plants: {
                                   data: []},
                                sensors: {
                                   data: []}}}

      @user = User.new({id: 1,
                      attributes: {
                           email: '123@gmail.com' },
                      relationships: {
                            gardens: {
                               data: [ @garden ] }}})

      @garden = @user.gardens.first
    end

    it "will send a logged in user to their dashboard instead of showing the welcome page" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit root_path

      expect(current_path).to eq(dashboard_path)
    end

    it "expects to see a My Solar Garden Project banner" do
      visit root_path

      expect(page).to have_content("My Solar Garden Project")
    end

    it "expects to see a description motto section" do
      visit root_path

      expect(page).to have_content("We love the planet")
    end

    it "expects to see a description block section" do
      visit root_path

      within ".w3-justify" do
        expect(page).to have_content("Lorem ipsum dolor sit amet")
      end
    end

    it "expects to see an image section with automation" do
      visit root_path

      expect(page).to have_css("img[src*='https://i.imgur.com/ESOXGPn.jpg']")
    end

    it "expects to see a Learn More button" do
      visit root_path

      expect(page).to have_link("Be The Change. Learn More")
    end

    it "expects to be sent to the Learn More page when Learn more button is clicked" do
      visit root_path

      click_link "Be The Change. Learn More"
      expect(current_path).to eq(learn_more_path)
    end

    it "expects to see a Login with Google button" do
      visit root_path

      expect(page).to have_link("Login with Google")
    end
    # We are not sure how to test this quite yet. I think once the OAuth is complete this can be tested.
    xit "expects to be sent to the Google auth when the button is clicked" do
      visit root_path

      click_link "Login with Google"
      expect(current_path).to eq('/auth/:provider/callback')
    end
  end
end
