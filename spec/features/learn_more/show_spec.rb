require 'rails_helper'

RSpec.describe 'Learn More page' do

  describe 'as a visitor' do
    before :each do
      visit learn_more_path
    end

    it "visitor does not see a navbar" do
      expect(page).to_not have_link("Learn More")
      expect(page).to_not have_link("Logout")
      expect(page).to_not have_link("Profile")
    end

    it "a visitor can see" do
      expect(page).to have_content("Learn More")
      expect(page).to have_link("Login with Google")
      expect(page).to have_css("img[src*='https://media.wired.com/photos/593258d526780e6c04d2b157/191:100/w_1280,c_limit/garden-sensor-ft.jpg']")
      expect(page).to have_css("img[src*='https://www.trees.com/sites/default/files/2019-09/soil-moisture-meter.jpg']")
      expect(page).to have_css("img[src*='https://www.cooking-hacks.com/media/cooking/images/documentation/open_garden/indoor_plant_4_small.png']")
    end

    it "expects to be sent to the Learn More page when Learn more button is clicked" do
      visit learn_more_path

      click_link "Back to Welcome"
      expect(current_path).to eq(root_path)
    end

    it "expects to see a Login with Google button" do
      visit root_path

      expect(page).to have_link("Login with Google")
    end

    it "expects to see a description as to why to log in with google block section" do
      visit root_path

      expect(page).to have_content("Login with Google to:")
      expect(page).to have_content("- Set up a garden -")
      expect(page).to have_content("- Track your sensor data -")
      expect(page).to have_content("- Track the health of your plants and soil -")
    end
  end

  describe 'a logged in user' do
    before :each do
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit learn_more_path
    end

    it "a logged in user does not see" do
      expect(page).to_not have_link("Login with Google")
    end

    it "a logged in user can see a navbar" do
      expect(page).to have_link("Welcome")
      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Learn More")
      expect(page).to have_link("Logout")
      expect(page).to have_link("Profile")
    end

    it "a logged in user can see" do
      expect(page).to have_content("Learn More")
      expect(page).to have_css("img[src*='https://media.wired.com/photos/593258d526780e6c04d2b157/191:100/w_1280,c_limit/garden-sensor-ft.jpg']")
      expect(page).to have_css("img[src*='https://www.trees.com/sites/default/files/2019-09/soil-moisture-meter.jpg']")
      expect(page).to have_css("img[src*='https://www.cooking-hacks.com/media/cooking/images/documentation/open_garden/indoor_plant_4_small.png']")
    end
  end
end
