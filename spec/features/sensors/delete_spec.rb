require 'rails_helper'

RSpec.describe 'On the garden show page' do
  describe "as a logged in user" do
    before :each do
      @user_with_gardens = User.new({id: 2,
      attributes: {
        email: 'planter@gmail.com' },
        relationships: {
          gardens: {
            data: [ {id: '3', type: 'garden'}, {id: '4', type: 'garden'}] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_gardens)
    end

    it "I can delete a sensor", :vcr do
      visit garden_path(4)

      sensors = page.all('.sensor')
      total = sensors.size

      first('.sensor').click_button('Delete')

      expect(current_path).to eq(garden_path(4))
      expect(page.all('.sensor').size).to eq(total - 1)
    end
  end
end
