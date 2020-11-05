require 'rails_helper'

RSpec.describe 'UserService' do
  before :each do
    @user = User.new({id: 1,
                    location: {
                            lat: 39.74,
                            lon: -104.98
                          },
                    attributes: {
                        email: '123@gmail.com' },
                    relationships: {
                        gardens: {
                            data: [ { id: 1,
                                      attributes: {
                                          name: 'My Garden',
                                          latitude: 23.0,
                                          longitude: 24.0,
                                          description: 'Simple Garden',
                                          private: false }} ] }}})
  end

  it 'update_email() returns json of updated information' do
    expected_output = File.read('spec/fixtures/user_update.json')
    stub_request(:patch, "#{ENV['BE_URL']}/api/v1/users/#{@user.id}?id=#{@user.id}&update_user%5Bemail%5D=abc@gmail.com").
         to_return(status: 200, body: expected_output, headers: {})
    results = UserService.update_email(@user.id, 'abc@gmail.com')
    expect(results).to be_a(Faraday::Response)
    expect(results.body).to be_a(String)
    expect(results.body).to_not be_empty
  end

  it 'delete_user() returns nothing' do
    stub_request(:delete, "#{ENV['BE_URL']}/api/v1/users/#{@user.id}").
       to_return(status: 200, body: "", headers: {})
    results = UserService.delete_user(@user.id)
    expect(results).to be_a(Faraday::Response)
    expect(results.body).to be_a(String)
    expect(results.body).to be_empty
  end
end
