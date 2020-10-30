require 'rails_helper'

RSpec.describe 'Navbar' do
  before :each do
    @user = User.new({id: 1,
                      attributes: { email: "123@gmail.com" },
                      relationships: { gardens: { data: [] }}})

    @garden = Garden.new({id: 1,
                        attributes: {
                          longitude: 23.573,
                          latitude: 50.428,
                          name: 'name',
                          description: 'description'},
                        relationships: { plants: { data: []}, sensors: { data: []}
                        }})

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

    @sensor = Sensor.new({id: 1,
                      attributes: {
                        garden_id: @garden.id,
                        sensor_type: 1298,
                        min_threshold: 30,
                        max_threshold: 390
                       }})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/users"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/dashboard"
    save_and_open_page
    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/gardens/#{@garden.id}"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/gardens/new"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/gardens/update"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/plants/#{@plant.id}"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/plants/new"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/plants/update"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/sensors/#{@sensor.id}"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/sensors/new"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/sensors/update"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit "/learn_more"

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end

  it "no longer sees my gardens, my impact, learn more, profile and logout" do
    visit "/users"

    click_on 'Logout'

    expect(current_path).to eq(root_path)

    expect(page).to have_link('Login')

    # expect(page).to_not have(".navbar")
  end
end
