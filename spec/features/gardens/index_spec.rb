require 'rails_helper'

RSpec.describe 'Index Page' do
  describe 'a logged in user' do
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
  end
end
