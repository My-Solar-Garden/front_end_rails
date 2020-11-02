require "rails_helper"

RSpec.describe "Sensors" do
  describe "CRUD Requests" do
    before :each do
      @user = create :user
      @garden = create(:garden)
      @user_garden = create(:user_garden, user_id: @user.id, garden_id: @garden.id)
      @moisture_sensor = create(:sensor, :moisture_sensor, garden_id: @garden.id)
      @light_sensor = create(:sensor, :light_sensor, garden_id: @garden.id)
    end

    describe 'happy paths' do
      it "can get all sensors for a garden" do
        get "/api/v1/sensors"

        expect(response).to be_successful

        sensors = JSON.parse(response.body, symbolize_names: true)

        expect(sensors).to be_an(Hash)
        expect(sensors[:data]).to be_an(Array)
        expect(sensors[:data].count).to eq(2)

       sensors[:data].each do |sensor|
         expect(sensor).to have_key(:id)
         expect(sensor[:id]).to be_a(String)

         expect(sensor).to have_key(:type)
         expect(sensor[:type]).to be_a(String)

         expect(sensor).to have_key(:attributes)
         expect(sensor[:attributes]).to be_a(Hash)

         expect(sensor[:attributes]).to have_key(:min_threshold)
         expect(sensor[:attributes][:min_threshold]).to be_a(Integer)

         expect(sensor[:attributes]).to have_key(:max_threshold)
         expect(sensor[:attributes][:max_threshold]).to be_a(Integer)

         expect(sensor[:attributes]).to have_key(:sensor_type)
         expect(sensor[:attributes][:sensor_type]).to be_a(String)

         expect(sensor).to have_key(:relationships)
         expect(sensor[:relationships]).to have_key(:garden)
         expect(sensor[:relationships][:garden]).to have_key(:data)
         expect(sensor[:relationships][:garden][:data]).to have_key(:id)
         expect(sensor[:relationships][:garden][:data]).to have_key(:type)
         expect(sensor[:relationships][:garden][:data][:id]).to be_a(String)
         expect(sensor[:relationships][:garden][:data][:type]).to be_a(String)
       end
      end

      it "can get one sensor from a garden" do
        get "/api/v1/sensors/#{@moisture_sensor.id}"

        expect(response).to be_successful

        sensor = JSON.parse(response.body, symbolize_names: true)

        expect(sensor).to be_an(Hash)
        expect(sensor[:data]).to be_an(Hash)

        expect(sensor[:data]).to have_key(:id)
        expect(sensor[:data][:id]).to be_a(String)

        expect(sensor[:data]).to have_key(:type)
        expect(sensor[:data][:type]).to be_a(String)

        expect(sensor[:data]).to have_key(:attributes)
        expect(sensor[:data][:attributes]).to be_a(Hash)

        expect(sensor[:data][:attributes]).to have_key(:min_threshold)
        expect(sensor[:data][:attributes][:min_threshold]).to be_a(Integer)

        expect(sensor[:data][:attributes]).to have_key(:max_threshold)
        expect(sensor[:data][:attributes][:max_threshold]).to be_a(Integer)

        expect(sensor[:data][:attributes]).to have_key(:sensor_type)
        expect(sensor[:data][:attributes][:sensor_type]).to be_a(String)

        expect(sensor[:data]).to have_key(:relationships)
        expect(sensor[:data][:relationships]).to have_key(:garden)
        expect(sensor[:data][:relationships][:garden]).to have_key(:data)
        expect(sensor[:data][:relationships][:garden][:data]).to have_key(:id)
        expect(sensor[:data][:relationships][:garden][:data]).to have_key(:type)
        expect(sensor[:data][:relationships][:garden][:data][:id]).to be_a(String)
        expect(sensor[:data][:relationships][:garden][:data][:type]).to be_a(String)
      end

      it "can create a sensor for a garden" do
        sensor_params = {
                         min_threshold: 5,
                         max_threshold: 14,
                         sensor_type: 0,
                         garden_id: @garden.id
                       }
         headers = {"CONTENT_TYPE" => "application/json"}

         post "/api/v1/sensors", headers: headers, params: JSON.generate(sensor_params)

         expect(response).to be_successful

         sensors = JSON.parse(response.body, symbolize_names: true)
         sensor = Sensor.last


         expect(sensor.sensor_type).to eq("moisture")
         expect(sensor.min_threshold).to eq(sensor_params[:min_threshold])
         expect(sensor.max_threshold).to eq(sensor_params[:max_threshold])
         expect(sensor.garden_id).to eq(sensor_params[:garden_id])

         expect(sensors).to be_an(Hash)
         expect(sensors[:data]).to be_an(Hash)
         expect(sensors[:data][:attributes]).to be_an(Hash)

         expect(sensors[:data]).to have_key(:id)
         expect(sensors[:data][:id]).to be_a(String)

         expect(sensors[:data]).to have_key(:type)
         expect(sensors[:data][:type]).to be_a(String)

         expect(sensors[:data]).to have_key(:attributes)
         expect(sensors[:data][:attributes]).to be_a(Hash)

         expect(sensors[:data][:attributes]).to have_key(:min_threshold)
         expect(sensors[:data][:attributes][:min_threshold]).to be_a(Integer)

         expect(sensors[:data][:attributes]).to have_key(:max_threshold)
         expect(sensors[:data][:attributes][:max_threshold]).to be_a(Integer)

         expect(sensors[:data][:attributes]).to have_key(:sensor_type)
         expect(sensors[:data][:attributes][:sensor_type]).to be_a(String)

         expect(sensors[:data]).to have_key(:relationships)
         expect(sensors[:data][:relationships]).to have_key(:garden)
         expect(sensors[:data][:relationships][:garden]).to have_key(:data)
         expect(sensors[:data][:relationships][:garden][:data]).to have_key(:id)
         expect(sensors[:data][:relationships][:garden][:data]).to have_key(:type)
         expect(sensors[:data][:relationships][:garden][:data][:id]).to be_a(String)
         expect(sensors[:data][:relationships][:garden][:data][:type]).to be_a(String)
      end

      it "can update one sensor from a garden" do
        sensor_params = {
                         min_threshold: 22653,
                         max_threshold: 4235,
                       }
         headers = {"CONTENT_TYPE" => "application/json"}

         patch "/api/v1/sensors/#{@moisture_sensor.id}", headers: headers, params: JSON.generate(sensor_params)

         expect(response).to be_successful

         updated_sensor = JSON.parse(response.body, symbolize_names: true)

         expect(updated_sensor).to be_an(Hash)
         expect(updated_sensor[:data]).to be_an(Hash)
         expect(updated_sensor[:data][:id]).to eq(@moisture_sensor.id.to_s)
         expect(updated_sensor[:data][:attributes][:sensor_type]).to eq("moisture")
         expect(updated_sensor[:data][:attributes][:min_threshold]).to eq(22653)
         expect(updated_sensor[:data][:attributes][:max_threshold]).to eq(4235)

         expect(updated_sensor).to be_an(Hash)
         expect(updated_sensor[:data]).to be_an(Hash)
         expect(updated_sensor[:data][:attributes]).to be_an(Hash)

         expect(updated_sensor[:data]).to have_key(:id)
         expect(updated_sensor[:data][:id]).to be_a(String)

         expect(updated_sensor[:data]).to have_key(:type)
         expect(updated_sensor[:data][:type]).to be_a(String)

         expect(updated_sensor[:data]).to have_key(:attributes)
         expect(updated_sensor[:data][:attributes]).to be_a(Hash)

         expect(updated_sensor[:data][:attributes]).to have_key(:min_threshold)
         expect(updated_sensor[:data][:attributes][:min_threshold]).to be_a(Integer)

         expect(updated_sensor[:data][:attributes]).to have_key(:max_threshold)
         expect(updated_sensor[:data][:attributes][:max_threshold]).to be_a(Integer)

         expect(updated_sensor[:data][:attributes]).to have_key(:sensor_type)
         expect(updated_sensor[:data][:attributes][:sensor_type]).to be_a(String)

         expect(updated_sensor[:data]).to have_key(:relationships)
         expect(updated_sensor[:data][:relationships]).to have_key(:garden)
         expect(updated_sensor[:data][:relationships][:garden]).to have_key(:data)
         expect(updated_sensor[:data][:relationships][:garden][:data]).to have_key(:id)
         expect(updated_sensor[:data][:relationships][:garden][:data]).to have_key(:type)
         expect(updated_sensor[:data][:relationships][:garden][:data][:id]).to be_a(String)
         expect(updated_sensor[:data][:relationships][:garden][:data][:type]).to be_a(String)
      end

      it "can destroy one sensor from a garden" do
        expect(Sensor.count).to eq(2)

        delete "/api/v1/sensors/#{@moisture_sensor.id}"

        expect(response).to be_successful
        expect(Sensor.count).to eq(1)
      end
    end

    describe 'sad paths' do
      it "cannot create a sensor for a garden with a missing param" do
        expect(Sensor.count).to eq(2)

        sensor_params = {
                         min_threshold: 5,
                         max_threshold: 14,
                         garden_id: @garden.id
                       }
         headers = {"CONTENT_TYPE" => "application/json"}

         post "/api/v1/sensors", headers: headers, params: JSON.generate(sensor_params)

         expect(Sensor.count).to eq(2)
         expect(response.body).to eq("")
      end

      it "cannot update a sensor for a garden with a bad param" do
        expect(Sensor.count).to eq(2)

        sensor_params = {
                         max_threshold: "hello"
                       }
         headers = {"CONTENT_TYPE" => "application/json"}

         patch "/api/v1/sensors/#{@moisture_sensor.id}", headers: headers, params: JSON.generate(sensor_params)

         expect(response.body).to eq("")
      end

      it "returns nil when a sensor show is called with an id that doesnt exist" do
        get "/api/v1/sensors/24562"

        expect(response.body).to eq("")
      end

      it "returns nil when a delete sensor request is called with an id that doesnt exist" do
        delete "/api/v1/sensors/134651"

        expect(response.body).to eq("")
      end
    end
  end
end
