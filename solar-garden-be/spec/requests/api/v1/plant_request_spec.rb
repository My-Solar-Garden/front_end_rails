require 'rails_helper'

describe 'plant API' do
  describe 'happy paths' do
    it 'can return a list of plants' do
      create_list(:plant, 10)
      get "/api/v1/plants"
      expect(response).to be_successful

      plants = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(plants).to be_an(Array)
      expect(plants.count).to eq(10)

      plants.each do |plant|
        expect(plant).to have_key(:id)
        expect(plant[:id]).to be_a(String)

        expect(plant).to have_key(:type)
        expect(plant[:type]).to be_an(String)

        expect(plant).to have_key(:relationships)
        expect(plant[:relationships]).to be_a(Hash)
        expect(plant[:relationships]).to have_key(:garden_plants)
        expect(plant[:relationships]).to have_key(:gardens)

        expect(plant).to have_key(:attributes)
        expect(plant[:attributes]).to be_a(Hash)

        expect(plant[:attributes]).to have_key(:image)
        expect(plant[:attributes][:image]).to be_an(String)

        expect(plant[:attributes]).to have_key(:name)
        expect(plant[:attributes][:name]).to be_an(String)

        expect(plant[:attributes]).to have_key(:species)
        expect(plant[:attributes][:species]).to be_an(String)

        expect(plant[:attributes]).to have_key(:description)
        expect(plant[:attributes][:description]).to be_an(String)

        expect(plant[:attributes]).to have_key(:light_requirements)
        expect(plant[:attributes][:light_requirements]).to be_an(String)

        expect(plant[:attributes]).to have_key(:water_requirements)
        expect(plant[:attributes][:water_requirements]).to be_an(String)

        expect(plant[:attributes]).to have_key(:when_to_plant)
        expect(plant[:attributes][:when_to_plant]).to be_an(String)

        expect(plant[:attributes]).to have_key(:harvest_time)
        expect(plant[:attributes][:harvest_time]).to be_an(String)

        expect(plant[:attributes]).to have_key(:common_pests)
        expect(plant[:attributes][:common_pests]).to be_an(String)
      end
    end

    it 'can return a plant by its id' do
      new_plant = create(:plant)
        get "/api/v1/plants/#{new_plant.id}"
        expect(response).to be_successful

        plant = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(plant).to have_key(:id)
        expect(plant[:id]).to be_a(String)

        expect(plant).to have_key(:type)
        expect(plant[:type]).to be_an(String)

        expect(plant).to have_key(:relationships)
        expect(plant[:relationships]).to be_a(Hash)
        expect(plant[:relationships]).to have_key(:garden_plants)
        expect(plant[:relationships]).to have_key(:gardens)

        expect(plant).to have_key(:attributes)
        expect(plant[:attributes]).to be_a(Hash)

        expect(plant[:attributes]).to have_key(:image)
        expect(plant[:attributes][:image]).to be_an(String)

        expect(plant[:attributes]).to have_key(:name)
        expect(plant[:attributes][:name]).to be_an(String)

        expect(plant[:attributes]).to have_key(:species)
        expect(plant[:attributes][:species]).to be_an(String)

        expect(plant[:attributes]).to have_key(:description)
        expect(plant[:attributes][:description]).to be_an(String)

        expect(plant[:attributes]).to have_key(:light_requirements)
        expect(plant[:attributes][:light_requirements]).to be_an(String)

        expect(plant[:attributes]).to have_key(:water_requirements)
        expect(plant[:attributes][:water_requirements]).to be_an(String)

        expect(plant[:attributes]).to have_key(:when_to_plant)
        expect(plant[:attributes][:when_to_plant]).to be_an(String)

        expect(plant[:attributes]).to have_key(:harvest_time)
        expect(plant[:attributes][:harvest_time]).to be_an(String)

        expect(plant[:attributes]).to have_key(:common_pests)
        expect(plant[:attributes][:common_pests]).to be_an(String)
    end

    it 'can create a new plant' do
      plant_params = ({
         image: 'image.url',
         name: 'plant name',
         species: 'plant species',
         description: 'plant description',
         light_requirements: 'light needed for plant',
         water_requirements: 'water needed for plant',
         when_to_plant: 'when to plant',
         harvest_time: 'time to harvest',
         common_pests: 'common pests for plant'
        })

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/plants", headers: headers, params: JSON.generate(plant_params)

        plant = Plant.last

        expect(response).to be_successful
        expect(plant.image).to eq(plant_params[:image])
        expect(plant.name).to eq(plant_params[:name])
        expect(plant.species).to eq(plant_params[:species])
        expect(plant.description).to eq(plant_params[:description])
        expect(plant.light_requirements).to eq(plant_params[:light_requirements])
        expect(plant.water_requirements).to eq(plant_params[:water_requirements])
        expect(plant.when_to_plant).to eq(plant_params[:when_to_plant])
        expect(plant.harvest_time).to eq(plant_params[:harvest_time])
        expect(plant.common_pests).to eq(plant_params[:common_pests])
      end

      it 'can update an existing plant' do
        plant = create(:plant)
        plant_params = { name: 'a differnt name'}

        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch "/api/v1/plants/#{plant.id}", headers: headers, params: JSON.generate(plant_params)
        expect(response).to be_successful
        updated_plant = Plant.find_by(id: plant.id)

        expect(updated_plant.name).to_not eq(plant.name)
        expect(updated_plant.name).to eq(plant_params[:name])
      end

      it 'can destroy a plant' do
        plant = create(:plant)

        expect(Plant.count).to eq(1)
        delete "/api/v1/plants/#{plant.id}"
        expect(response).to be_successful
        expect(Plant.count).to eq(0)
        expect{Plant.find(plant.id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
  end

  describe 'sad paths' do
   it 'index - returns a 204 if query entered wrong' do
     get '/api/v1/plants'
     expect(response).to be_successful
     expect(response.status).to eq(204)
   end

   it 'show - returns a 204 if query entered wrong' do
     get "/api/v1/plants/99999"
     expect(response).to be_successful
     expect(response.status).to eq(204)
   end

   it 'create - returns a 204 if query entered wrong' do
     post "/api/v1/plants"
     expect(response).to be_successful
     expect(response.status).to eq(204)
   end

   it 'update - returns a 204 if query entered wrong' do
     patch "/api/v1/plants/999999"
     expect(response).to be_successful
     expect(response.status).to eq(204)
   end

   it 'delete - returns a 204 if query entered wrong' do
     delete "/api/v1/plants/999999"
     expect(response).to be_successful
     expect(response.status).to eq(204)
   end
 end
end
