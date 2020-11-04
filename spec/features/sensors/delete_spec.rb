require 'rails_helper'

describe 'On the garden show page' do
  before :each do
    @user_with_gardens = User.new({id: 2,
    attributes: {
      email: 'planter@gmail.com' },
      relationships: {
        gardens: {
          data: [ {id: '3', type: 'garden'}, {id: '4', type: 'garden'}] }}})

    @garden1 = File.read('spec/fixtures/garden_with_sensors.json')
    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/3").to_return(status: 200, body: @garden1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_without_gardens)
  end

  it "I can delete a sensor" do
    visit garden_path(1)

    sensors = page.all('.sensor')
    total = sensors.size

    first('.sensor').click_button('Delete')
    save_and_open_page

    # expect(current_path).to eq(garden_path(1))
    expect(page.all('.sensor').size).to eq(total - 1)
  end
end
