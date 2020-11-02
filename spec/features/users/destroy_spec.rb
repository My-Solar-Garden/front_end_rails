require 'rails_helper'

RSpec.describe 'User destroy' do
  describe 'a user' do
    it 'can delete their profile' do
      user = User.new({id: 1,
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      stub_request(:delete, "#{ENV['BE_URL']}/api/v1/users/#{user.id}").
         to_return(status: 200, body: "", headers: {})

      visit profile_path
      click_button 'Delete Profile'
      expect(current_path).to eq(root_path)
      save_and_open_page
    end
  end
end
