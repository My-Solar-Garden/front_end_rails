require 'rails_helper'

describe SessionService do
  it "returns garden details data" do
    user_data = SessionService.session_details(stub_omniauth)
    # require "pry"; binding.pry
    expect(user_data).to have_key(:data)
    expect(user_data[:data]).to be_a(Hash)

    expect(user_data[:data]).to have_key(:id)
    expect(user_data[:data][:id]).to be_a(String)

    expect(user_data[:data]).to have_key(:type)
    expect(user_data[:data][:type]).to be_a(String)

    expect(user_data[:data]).to have_key(:attributes)
    expect(user_data[:data][:attributes]).to be_a(Hash)

    expect(user_data[:data][:attributes]).to have_key(:id)
    expect(user_data[:data][:attributes][:id]).to be_a(Integer)

    expect(user_data[:data][:attributes]).to have_key(:email)
    expect(user_data[:data][:attributes][:email]).to be_a(String)

    expect(user_data[:data]).to have_key(:relationships)
    expect(user_data[:data][:relationships]).to be_a(Hash)

    expect(user_data[:data][:relationships]).to have_key(:user_gardens)
    expect(user_data[:data][:relationships][:user_gardens]).to be_a(Hash)

    expect(user_data[:data][:relationships]).to have_key(:gardens)
    expect(user_data[:data][:relationships][:gardens]).to be_a(Hash)

    expect(user_data[:data][:relationships][:user_gardens]).to have_key(:data)
    expect(user_data[:data][:relationships][:user_gardens][:data]).to be_a(Array)

    expect(user_data[:data][:relationships][:gardens]).to have_key(:data)
    expect(user_data[:data][:relationships][:gardens][:data]).to be_a(Array)
  end
end
