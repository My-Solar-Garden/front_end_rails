require 'rails_helper'

RSpec.describe 'User profile page' do
  describe "as a visitor" do
    before :each do
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ { id: 1,
                                        attributes: {
                                            name: 'My Garden',
                                            latitude: 23.0,
                                            longitude: 24.0,
                                            description: 'Simple Garden',
                                            private: false }} ] }}})
    end

    it 'cannot visit page' do
      visit edit_user_path(@user.id)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'a user' do
    it 'can change their email' do
      @user = User.new({id: 1,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ { id: 1,
                                        attributes: {
                                            name: 'My Garden',
                                            latitude: 23.0,
                                            longitude: 24.0,
                                            description: 'Simple Garden',
                                            private: false }} ] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      expected_output = File.read('spec/fixtures/user_update.json')
      stub_request(:patch, "#{ENV['BE_URL']}/api/v1/users/1?id=1&update_user%5Bemail%5D=abc@gmail.com").
           to_return(status: 200, body: expected_output, headers: {})

      visit edit_user_path(@user.id)
      fill_in :email, with: 'abc@gmail.com'
      click_button 'Update Information'
      expect(current_path).to eq(profile_path)
    end
  end
end
