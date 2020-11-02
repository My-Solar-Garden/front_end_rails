require 'rails_helper'

describe "Plant search" do
  it "can get list of plants with a search term" do
    get '/api/v1/plants/search?search_term=TOM'
    expect(response).to be_successful
    plants_with_tom = JSON.parse(response.body, symbolize_names: true)
    expect(plants_with_tom).to be_a Hash

    search_results = plants_with_tom[:data]
    expect(search_results).to be_a Array
    expect(search_results.count).to eq(1)
    expect(search_results[0][:attributes][:name].downcase.include?("tom")).to eq(true)
  end

  it "can get a more robust list of plants with a vague search term" do
    get '/api/v1/plants/search?search_term=on'
    expect(response).to be_successful
    plants_with_on = JSON.parse(response.body, symbolize_names: true)
    expect(plants_with_on).to be_a Hash

    search_results = plants_with_on[:data]
    expect(search_results).to be_a Array
    expect(search_results.count).to eq(3)
    expect(search_results[0][:attributes][:name].downcase.include?("on")).to eq(true)
    expect(search_results[1][:attributes][:name].downcase.include?("on")).to eq(true)
    expect(search_results[2][:attributes][:name].downcase.include?("on")).to eq(true)
  end
  
end