module Helpers
  def garden_details_response_structure_check(response)
    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)

    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_a(String)

    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to be_a(String)

    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to be_a(Hash)

    expect(response[:data][:attributes]).to have_key(:latitude)
    expect(response[:data][:attributes][:latitude]).to be_a(Float)

    expect(response[:data][:attributes]).to have_key(:longitude)
    expect(response[:data][:attributes][:longitude]).to be_a(Float)

    expect(response[:data][:attributes]).to have_key(:name)
    expect(response[:data][:attributes][:name]).to be_a(String)

    expect(response[:data][:attributes]).to have_key(:description)
    expect(response[:data][:attributes][:description]).to be_a(String)

    expect(response[:data][:attributes]).to have_key(:private)
    expect(response[:data][:attributes][:private]).to be_in([true, false])

    expect(response[:data]).to have_key(:relationships)
    expect(response[:data][:relationships]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:user_gardens)
    expect(response[:data][:relationships][:user_gardens]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:users)
    expect(response[:data][:relationships][:users]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:sensors)
    expect(response[:data][:relationships][:sensors]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:garden_plants)
    expect(response[:data][:relationships][:garden_plants]).to be_a(Hash)
  end

  def user_details_response_structure_check(response)
    expect(response).to have_key(:data)
    expect(response[:data]).to be_a(Hash)

    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_a(String)

    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to be_a(String)

    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to be_a(Hash)

    expect(response[:data][:attributes]).to have_key(:id)
    expect(response[:data][:attributes][:id]).to be_a(Integer)

    expect(response[:data][:attributes]).to have_key(:email)
    expect(response[:data][:attributes][:email]).to be_a(String)

    expect(response[:data]).to have_key(:relationships)
    expect(response[:data][:relationships]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:user_gardens)
    expect(response[:data][:relationships][:user_gardens]).to be_a(Hash)

    expect(response[:data][:relationships]).to have_key(:gardens)
    expect(response[:data][:relationships][:gardens]).to be_a(Hash)

    expect(response[:data][:relationships][:user_gardens]).to have_key(:data)
    expect(response[:data][:relationships][:user_gardens][:data]).to be_a(Array)

    expect(response[:data][:relationships][:gardens]).to have_key(:data)
    expect(response[:data][:relationships][:gardens][:data]).to be_a(Array)

  def sensor_structure_check(response)
    expect(response).to be_an(Hash)

    expect(response).to have_key(:id)
    expect(response[:id]).to be_a(String)

    expect(response).to have_key(:type)
    expect(response[:type]).to be_a(String)

    expect(response).to have_key(:attributes)
    expect(response[:attributes]).to be_a(Hash)

    expect(response[:attributes]).to have_key(:min_threshold)
    expect(response[:attributes][:min_threshold]).to be_a(Integer)

    expect(response[:attributes]).to have_key(:max_threshold)
    expect(response[:attributes][:max_threshold]).to be_a(Integer)

    expect(response[:attributes]).to have_key(:sensor_type)
    expect(response[:attributes][:sensor_type]).to be_a(String)

    expect(response).to have_key(:relationships)
    expect(response[:relationships]).to have_key(:garden)
    expect(response[:relationships][:garden]).to have_key(:data)
    expect(response[:relationships][:garden][:data]).to have_key(:id)
    expect(response[:relationships][:garden][:data]).to have_key(:type)
    expect(response[:relationships][:garden][:data][:id]).to be_a(String)
    expect(response[:relationships][:garden][:data][:type]).to be_a(String)
  end
end
