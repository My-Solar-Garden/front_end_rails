require 'rails_helper'

RSpec.describe Garden, type: :model do
  describe 'valdations' do
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
    it { should validate_presence_of :name }
    it { should allow_value(%w(true false)).for(:private) }
  end

  describe 'relationships' do
    it { should have_many :user_gardens }
    it { should have_many(:users).through(:user_gardens) }
    it { should have_many :sensors }
    it { should have_many :garden_plants }
    it { should have_many(:plants).through(:garden_plants) }
  end

  describe 'creation' do
    it 'can make a new user' do
      Garden.create!(latitude: 1.5, longitude: 1.5, name: 'Garden 1', private: false)
      expect(Garden.count).to eq(1)
    end
  end

  describe 'instance methods' do
    it 'can add existing plant' do
      garden = create(:garden)
      plant = create(:plant)
      garden.add_plant(plant)
      expect(garden.plants).to eq([plant])
      expect(plant.gardens).to eq([garden])
    end

    it 'can create and add plant' do
      garden = create(:garden)
      plant_params = {
        image: 'image.url',
        name: 'plant name',
        species: 'plant species',
        description: 'plant description',
        light_requirements: 'light needed for plant',
        water_requirements: 'water needed for plant',
        when_to_plant: 'when to plant',
        harvest_time: 'time to harvest',
        common_pests: 'common pests for plant',
      }
      garden.create_and_add_plant(plant_params)
      expect(garden.plants.count).to eq(1)
      expect(garden.plants.first.name).to eq(plant_params[:name])
      expect(garden.plants.first.image).to eq(plant_params[:image])
      expect(garden.plants.first.species).to eq(plant_params[:species])
      expect(garden.plants.first.description).to eq(plant_params[:description])
      expect(garden.plants.first.light_requirements).to eq(plant_params[:light_requirements])
      expect(garden.plants.first.when_to_plant).to eq(plant_params[:when_to_plant])
      expect(garden.plants.first.water_requirements).to eq(plant_params[:water_requirements])
      expect(garden.plants.first.harvest_time).to eq(plant_params[:harvest_time])
      expect(garden.plants.first.common_pests).to eq(plant_params[:common_pests])
    end
  end
end
