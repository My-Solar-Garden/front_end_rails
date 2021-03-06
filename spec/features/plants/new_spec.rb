require 'rails_helper'

RSpec.describe 'New Plant Page' do
  describe 'a visitor' do
    before :each do
      @public_garden = Garden.new({ id: 7,
                attributes: {
                    name: 'Cole Community Garden',
                    latitude: 39.45,
                    longitude: -104.58,
                    description: 'A diverse, dedicated group of students and neighbors who believe in bettering ourselves, our food supply and our community through urban gardening.',
                    private: false },
                relationships: { plants: {
                                    data: [{id: "1", type: "plant"}]},
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
    end

    it "cannot visit page" do
      visit "/gardens/#{@garden.id}/plants"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end


  end
end
