require 'rails_helper'

RSpec.describe GardenHealth, type: :model do
  describe 'valdations' do
    it { should validate_presence_of :reading_type }
    it { should validate_presence_of :reading }
    it { should validate_numericality_of :reading }
  end

  describe 'relationships' do
    it { should belong_to(:sensor).optional }
  end

  describe 'creation' do
    it 'can make a new user' do
      garden = Garden.create!(latitude: 1.5, longitude: 1.5, name: 'Garden 1', private: false)
      sensor = garden.sensors.create!(sensor_type: 0, min_threshold: 10, max_threshold: 20)
      GardenHealth.create!(reading_type: 0, reading: 1.5, time_of_reading: Date.today)
      GardenHealth.create!(reading_type: 0, reading: 1.5, time_of_reading: Date.today, sensor_id: sensor.id)
      expect(GardenHealth.count).to eq(2)
    end
  end
end
