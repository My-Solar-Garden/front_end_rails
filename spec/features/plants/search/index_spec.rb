require 'rails_helper'

RSpec.describe 'Plants Search Index Page' do
  it "displays searched for plants" do 
    json_response = File.read('spec/fixtures/garden_with_sensors.json')
      stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/3").to_return(status: 200, body: json_response)

      visit "/gardens/3"

      expect(page).to have_field('search_term')
      expect(page).to have_button('Find Plants')
      fill_in :search_term, with: 'on'
      click_on "Find Plants"
      expect(current_path).to eq('/plants/search')
      expect(page).to have_content('Onion')
      expect(page).to have_content('Tarragon')
      expect(page).to have_content('Watermelon')
  end

  it "can add plants" do 
    json_response = File.read('spec/fixtures/garden_with_sensors.json')
    stub_request(:get, "https://solar-garden-be.herokuapp.com/api/v1/gardens/3").to_return(status: 200, body: json_response)
    visit "/gardens/3"
    expect(page).to have_field('search_term')
    expect(page).to have_button('Find Plants')
    fill_in :search_term, with: 'on'
    click_on "Find Plants"
    within(".plant-33") do
      expect(page).to have_content('Watermelon')
      click_on "Add To Garden"
    end
    expect(current_path).to eq('gardens/3')
    expect(page).to have_content('Watermelon')
  end
end