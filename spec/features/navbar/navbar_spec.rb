require 'rails_helper'

RSpec.describe 'Navbar' do
  before :each do
    @plant = Plant.new({
                        id:1,
                        attributes: {
                          image: "url",
                          name: 'name',
                          species: 'species',
                          description: 'description',
                          light_requirements: 'alot',
                          water_requirements: 'medium',
                          when_to_plant: 'spring',
                          harvest_time: 'now',
                          common_pests: 'beetles'
                        }})

    @garden = { id: 4,
              attributes: {
                  name: 'My Garden',
                  latitude: 23.0,
                  longitude: 24.0,
                  description: 'Simple Garden',
                  private: false },
              relationships: { plants: {
                                  data: []},
                                users: {
                                  data: [{id: "4", type: "user"}]},
                               sensors: {
                                  data: []}}}

    @sensor = Sensor.new({id: 1,
                      attributes: {
                        garden_id: @garden[:id],
                        sensor_type: 1298,
                        min_threshold: 30,
                        max_threshold: 390
                       }})

    @user = User.new({id: 4,
                    attributes: {
                        email: '123@gmail.com' },
                    relationships: {
                        gardens: {
                            data: [ @garden ] }}})

    @garden = @user.gardens.first

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    response = File.read('spec/fixtures/public_garden.json')
    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/#{@garden[:id]}").to_return(status: 200, body: response)
  end

  it "can see my gardens, my impact, learn more, profile and logout on profile page" do
    visit "/users/#{@user.id}"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on dashboard" do
    visit "/dashboard"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on garden show page" do
    visit "/gardens/#{@garden[:id]}"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on garden update page" do
    visit "/gardens/#{@garden[:id]}/edit"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on create garden page" do
    visit "/gardens/new"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on plant show page" do
    visit "/plants/#{@plant.id}"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on plant new page" do
    visit "/plants/new"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on plant update page" do
    visit "/plants/update"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on sensor show page" do
    visit "/sensors/#{@sensor.id}"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on sensor new page" do
    visit "/sensors/new"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on sensor update page" do
    visit "/sensors/update"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout on learn more page" do
    visit "/learn_more"

    within "#navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  #The test below is currently not working because it needs OAuth to be functioning.  Turns out if you do the ApplicationController shortcut to make :current_user equal @user, then even if you do the destroy action, there isn't really a way to destroy the session, so :current_user is still not nil, so the welcome page won't ever not show the nav bar in this test.  The way around this is to have in the 'before do' the user log in through OAuth or what have you, and then in the test below, have them log out.

  xit "no longer sees my gardens, my impact, learn more, profile and logout on welcome page when not logged in" do
    visit "/users"

    click_on 'Logout'

    expect(current_path).to eq(root_path)

    expect(page).to_not have_link('My Gardens')
    expect(page).to_not have_link('My Impact')
    expect(page).to_not have_link('Learn More')
    expect(page).to_not have_link('Profile')
    expect(page).to_not have_link('Logout')
  end
end
