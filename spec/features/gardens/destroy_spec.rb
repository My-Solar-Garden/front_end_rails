require 'rails_helper'

RSpec.describe 'Delete garden functionality' do
  describe 'a logged in user' do
    before :each do
      @user_with_gardens = User.new({id: 4,
      attributes: {
        email: 'planter@gmail.com' },
      relationships: {
        gardens: {
          data: [ {id: '3', type: 'garden'}, {id: '4', type: 'garden'}] }}})

      garden1 = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/3").to_return(status: 200, body: garden1)

      garden2 = File.read('spec/fixtures/private_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/4").to_return(status: 200, body: garden2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_gardens)
    end

    xit 'can delete a garden from the dashboard' do
      visit dashboard_path

      @user_with_deleted_garden = User.new({id: 4,
      attributes: {
        email: 'planter@gmail.com' },
      relationships: {
        gardens: {
          data: [ {id: '4', type: 'garden'}] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_deleted_garden)

      within("#garden-#{@user_with_gardens.gardens[0][:id]}") do
        find('.fa-trash').click
      end

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_css("#garden-#{@user_with_gardens.gardens[1][:id]}")
      expect(page).to_not have_css("#garden-#{@user_with_gardens.gardens[0][:id]}")
    end

    xit 'can delete a garden from garden show page' do
      visit garden_show_path(@user_with_gardens.gardens[0][:id])

      @user_with_deleted_garden = User.new({id: 4,
      attributes: {
        email: 'planter@gmail.com' },
      relationships: {
        gardens: {
          data: [ {id: '4', type: 'garden'}] }}})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_deleted_garden)

      find('.fa-trash').click

      expect(current_path).to eq(dashboard_path)
    end
  end
end