require 'rails_helper'
RSpec.describe 'Plant Facade' do
  it 'returns a list of plant poros for the searched for plants', :vcr do
    plants = PlantFacade.search('on')
    expect(plants).to be_an(Array)
    expect(plants.first).to be_a(PlantPoro)
    expect(plants.first.name).to be_a(String)
    expect(plants.first.name.downcase.include?('on')).to eq(true)
  end
end