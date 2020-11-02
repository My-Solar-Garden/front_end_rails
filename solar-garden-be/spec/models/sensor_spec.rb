require 'rails_helper'

RSpec.describe Sensor, type: :model do
  describe 'valdations' do
    it { should validate_presence_of :min_threshold }
    it { should validate_presence_of :max_threshold }
  end

  describe 'relationships' do
    it { should belong_to :garden }
    it { should have_many :garden_healths }
  end

  describe 'creation' do
    it 'can make a new sensor' do
      garden = Garden.create!(latitude: 1.5, longitude: 1.5, name: 'Garden 1', private: false)
      garden.sensors.create!(sensor_type: 0, min_threshold: 10, max_threshold: 20)
      expect(Sensor.count).to eq(1)
    end
  end
end
