require 'rails_helper'

RSpec.describe GardenPlant, type: :model do
  describe 'valdations' do
    it { should validate_presence_of :planted_date }
  end

  describe 'relationships' do
    it { should belong_to :garden }
    it { should belong_to :plant }
  end
end
