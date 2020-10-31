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

    it "expects to see a Learn More button" do
      visit root_path

      expect(page).to have_button("Be The Change. Learn More")
    end

  end
end
