require 'rails_helper'

RSpec.describe 'New Sensor Page' do
  describe 'a logged in user' do
    before :each do
    @public_garden = Garden.new({ id: 4,
              attributes: {
                  name: 'Cole Community Garden',
                  latitude: 39.45,
                  longitude: -104.58,
                  description: 'A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.',
                  private: false },
              relationships: { plants: {
                                  data: []},
                                users: {
                                    data: [{id: "1", type: "user"}]},
                               sensors: {
                                  data: []}}})
    @user = User.new({id: 1,
                    attributes: {
                        email: '123@gmail.com' },
                    relationships: {
                        gardens: {
                            data: [ @public_garden ] }}})

    @garden = @user.gardens.first

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'has fields to add new sensor' do
      visit "/gardens/#{@garden.id}/sensors"

    end
  end
end
