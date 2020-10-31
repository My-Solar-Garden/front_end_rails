require 'rails_helper'

RSpec.describe 'User' do
  it 'exists' do
    attr = {
      "data": {
          "id": "1",
          "type": "user",
          "attributes": {
              "id": 1,
              "email": "billy@gmail.com"
          },
          "relationships": {
              "user_gardens": {
                  "data": []
              },
              "gardens": {
                  "data": []
              }
          }
      }
    }

    user = User.new(attr.deep_symbolize_keys[:data])

    expect(user).to be_a(User)

    expect(user.id).to be_a(String)
    expect(user.id).to eq('1')

    expect(user.email).to be_a(String)
    expect(user.email).to eq('billy@gmail.com')

    expect(user.gardens).to be_an(Array)
    expect(user.gardens).to eq([])
  end

  describe 'class methods' do

    describe 'find(user_id)' do
      it 'can fetch a user from backend api' do
        VCR.use_cassette('fetch_user') do
          user = User.find('1')
          expect(user).to be_a(User)
          expect(user.id).to eq('1')
          expect(user.email).to eq('billy@gmail.com')
          expect(user.gardens).to eq([])
        end
      end
    end
  end
end