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
      expect(page).to have_css("img[src*='https://www.backtoedenfilm.com/uploads/1/2/1/7/12171992/no-till-gardening_orig.png']")
      expect(page).to have_css("img[src*='https://i.pinimg.com/originals/39/c8/24/39c824083830d38102cfe1a2266077ef.jpg']")
      expect(page).to have_css("img[src*='https://hackster.imgix.net/uploads/attachments/228021/s72hqE6cgvSCK3uoLExL.uploads/tmp/15eebe6d-0e94-44df-a495-bb7d8008cbb2/tmp_image_0?auto=compress%2Cformat&w=900&h=675&fit=min']")
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
      expect(page).to have_css("img[src*='https://www.backtoedenfilm.com/uploads/1/2/1/7/12171992/no-till-gardening_orig.png']")
      expect(page).to have_css("img[src*='https://i.pinimg.com/originals/39/c8/24/39c824083830d38102cfe1a2266077ef.jpg']")
      expect(page).to have_css("img[src*='https://hackster.imgix.net/uploads/attachments/228021/s72hqE6cgvSCK3uoLExL.uploads/tmp/15eebe6d-0e94-44df-a495-bb7d8008cbb2/tmp_image_0?auto=compress%2Cformat&w=900&h=675&fit=min']")
      expect(page).to have_no_link("Be The Change. Learn More")
    end
  end
end
