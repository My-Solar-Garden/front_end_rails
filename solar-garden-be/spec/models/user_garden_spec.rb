require 'rails_helper'

RSpec.describe UserGarden, type: :model do
  describe 'relationships' do
    it { should belong_to :user}
    it { should belong_to :garden }
  end

  describe 'creation' do
    it 'can create user garden' do
      user = User.create!(email: 'test@gmail.com', provider: 'google', token: '1234', uid: '98765')
      user.gardens.create!(latitude: 1.5, longitude: 1.5, name: 'Garden 1', private: false)
      expect(UserGarden.count).to eq(1)
    end
  end
end
