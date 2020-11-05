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

      expect(page).to have_content("My Solar Garden is an impact")
    end

    it "expects to see a description as to why to log in with google block section" do
      visit root_path

      expect(page).to have_content("Login with Google to:")
      expect(page).to have_content("- Set up a garden -")
      expect(page).to have_content("- Track your sensor data -")
      expect(page).to have_content("- Track the health of your plants and soil -")
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

    it "can see link to visit privacy policy page" do
      visit root_path
      
      expect(page).to have_link("Visit our Privacy Policy Page")

      click_link "Visit our Privacy Policy Page"

      expect(current_path).to eq('/privacy')
    end

    it "expects to not see Login With Google if logged in" do
      @user = User.new({id: 2,
                        attributes: {
                          email: 'planter@gmail.com' },
                          relationships: {
                            gardens: {
                              data: [ {id: '3', type: 'garden'}, {id: '4', type: 'garden'}] }}})
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit root_path

      expect(page).to_not have_content("Login with Google")
    end
  end
end
