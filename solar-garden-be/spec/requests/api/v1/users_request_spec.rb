require 'rails_helper'

RSpec.describe 'USER API' do
  describe 'happy-paths' do
    it 'sends a list of users' do
      create_list(:user, 5)

      get '/api/v1/users'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      users = json[:data]

      expect(users).to be_an(Array)
      expect(users.count).to eq(5)

      users.each do |user|
        expect(user).to have_key(:id)
        expect(user[:id]).to be_an(String)
        expect(user).to have_key(:type)
        expect(user[:type]).to be_an(String)
        expect(user).to have_key(:relationships)
        expect(user[:relationships]).to be_a(Hash)
        expect(user[:relationships]).to have_key(:user_gardens)
        expect(user[:relationships]).to have_key(:gardens)
        expect(user).to have_key(:attributes)
        expect(user[:attributes]).to be_a(Hash)
        expect(user[:attributes]).to have_key(:id)
        expect(user[:attributes][:id]).to be_an(Integer)
        expect(user[:attributes]).to have_key(:email)
        expect(user[:attributes][:email]).to be_an(String)
      end
    end

    it 'can get one user by its id' do
      id = create(:user).id

      get "/api/v1/users/#{id}"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      user = json[:data]

      expect(user).to have_key(:id)
      expect(user[:id]).to be_an(String)

      expect(user).to have_key(:type)
      expect(user[:type]).to be_an(String)

      expect(user).to have_key(:attributes)
      expect(user[:attributes]).to be_a(Hash)

      expect(user[:attributes]).to have_key(:email)
      expect(user[:attributes][:email]).to be_an(String)
    end

    it 'can create a new user' do
      user_params = {credentials: {token: "123"}, info: {email: Faker::Internet.email}, provider: "google_oauth2", uid: "98765"}
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      created_user = User.last

      expect(response).to be_successful
      expect(created_user.email).to eq(user_params[:info][:email])
      expect(created_user.provider).to eq(user_params[:provider])
      expect(created_user.token).to eq(user_params[:credentials][:token])
      expect(created_user.uid).to eq(user_params[:uid])

    end

    it 'can update an existing user' do
      user = create(:user)
      previous_token = User.last.token
      user_params = {credentials: {token: "123"}, info: {email: Faker::Internet.email}, provider: "google_oauth2", uid: "98765"}
      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/users/#{user.id}", headers: headers, params: JSON.generate(user_params)

      user = User.find(user.id)

      expect(response).to be_successful

      expect(user.token).to_not eq(previous_token)
      expect(user.token).to eq(user_params[:credentials][:token])
    end

    it 'can destroy a user' do
      id = create(:user).id

      expect{ delete "/api/v1/users/#{id}" }.to change(User, :count).by(-1)

      expect(response).to be_successful
      expect{User.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'sad-paths' do
    it 'index - returns a 204 if user table is empty' do
      get '/api/v1/users'
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'show - returns a 204 if query entered wrong' do
      get "/api/v1/users/99999"
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    # it 'create - returns a 204 if query entered wrong' do
    #   post "/api/v1/users"
    #   expect(response).to be_successful
    #   expect(response.status).to eq(204)
    # end

    it 'update - returns a 204 if query entered wrong' do
      patch "/api/v1/users/999999"
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'delete - returns a 204 if query entered wrong' do
      delete "/api/v1/users/999999"
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end
end
