require 'rails_helper'

RSpec.describe 'Navbar' do
  before :each do
    @user = User.new({id: 1,
                      attributes: { email: "123@gmail.com" },
                      relationships: { gardens: { data: [] }}})
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "can see my gardens, my impact, learn more, profile and logout" do
    visit gardens_path

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end
  it "can see my gardens, my impact, learn more, profile and logout" do
    visit plants_path

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end
  it "can see my gardens, my impact, learn more, profile and logout" do
    visit sensors_path

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end
  it "can see my gardens, my impact, learn more, profile and logout" do
    visit learn_more_path

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end
  it "can see my gardens, my impact, learn more, profile and logout" do
    visit profile_path

    within ".navbar-#{@user.id}" do
      expect(page).to have_link('My Gardens')
      expect(page).to have_link('My Impact')
      expect(page).to have_link('Learn More')
      expect(page).to have_link('Profile')
      expect(page).to have_link('Logout')
    end
  end
  it "no longer sees my gardens, my impact, learn more, profile and logout" do
    visit profile_path

    click_on 'Logout'

    expect(current_path).to eq(root_path)

    expect(page).to_not have(".navbar")
  end
end
