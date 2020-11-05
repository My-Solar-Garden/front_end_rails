require 'rails_helper'

RSpec.describe 'Navbar' do
  describe "when using 'allow_any_instance_of' method of logging a user in" do
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

      @sensor = Sensor.new({id: 4,
                        attributes: {
                          sensor_type: 1298,
                          min_threshold: 30,
                          max_threshold: 390
                        },
                        relationships:
                        {
                          garden:{data:{id:@garden[:id]}},
                          garden_healths: {
                              data: []
                          }
                        }
                         })

      @user = User.new({id: 4,
                      attributes: {
                          email: '123@gmail.com' },
                      relationships: {
                          gardens: {
                              data: [ @garden ] }}})

      @garden = @user.gardens.first

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      response = File.read('spec/fixtures/public_garden.json')
      stub_request(:get, "#{ENV['BE_URL']}/api/v1/gardens/#{@garden[:id]}").to_return(status: 200, body: response)

      sensor = File.read('spec/fixtures/sensor.json')
      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/sensors/#{@sensor.id}").to_return(status: 200, body: sensor)
    end

    it "can see my dash, my impact, learn more, profile and logout on profile page" do
      visit profile_path

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on dashboard" do
      visit "/dashboard"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on garden show page" do
      visit "/gardens/#{@garden[:id]}"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on garden update page" do
      visit "/gardens/#{@garden[:id]}/edit"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on create garden page" do
      visit "/gardens/new"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on plant show page" do
      visit "/plants/#{@plant.id}"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on plant new page" do
      visit "/plants/new"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on plant update page" do
      visit "/plants/update"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on sensor show page" do
      visit "/sensors/#{@sensor.id}"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on sensor new page" do
      visit "/sensors/new"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on sensor update page" do
      visit "/sensors/1/edit"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end

    it "can see my dash, my impact, learn more, profile and logout on learn more page" do
      visit "/learn_more"

      within "#navbar-#{@user.id}" do
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('My Impact')
        expect(page).to have_link('Learn More')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
      end
    end
  end

  describe "logging in with Login button" do
    it "I can log out" do
      VCR.use_cassette('google_oauth') do
        visit root_path
        stub_omniauth
        click_link 'Login with Google'
        click_link 'Logout'

        expect(page).to_not have_link('My Gardens')
        expect(page).to_not have_link('My Impact')
        expect(page).to_not have_link('Profile')
        expect(page).to_not have_link('Logout')
      end
    end
  end
end
