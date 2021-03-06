class GardensController < ApplicationController
  before_action :require_user, except: [:show]

  # def index
  #   @gardens = GardenFacade.create_garden_objects(current_user.gardens)
  # end

  def show
    garden = GardenFacade.garden_details(params)
    @sensors = SensorFacade.all_sensors_for_garden(params)
    @weather = WeatherFacade.create_weather_objects([garden.latitude, garden.longitude])
    temp_sensor = @sensors.find { |sensor| sensor.sensor_type == 'temperature' }
    @temperature = GardenHealthFacade.last_reading(temp_sensor) if temp_sensor
    light_sensor = @sensors.find { |sensor| sensor.sensor_type == 'light' }
    @light = GardenHealthFacade.last_reading(light_sensor) if light_sensor

    @plants = PlantFacade.all_plants_for_garden(params)

    if !garden.is_private || current_users_garden?(garden)
      @garden = garden
    else
      render_404
    end
  end

  def new; end

  def create
    GardenFacade.new_garden(garden_params, current_user.id)
    redirect_to dashboard_path
  end

  def edit
    @garden = GardenFacade.garden_details(params)
  end

  def update
    GardenFacade.update(params, current_user.id)
    redirect_to garden_show_path(params[:id])
  end

  def destroy
    GardenFacade.destroy(params[:id])
    refresh_current_user
    redirect_to dashboard_path
  end

  private

  def garden_params
    params.permit(:name, :latitude, :longitude, :private, :description)
  end

  def current_users_garden?(garden)
    garden.user_ids.include?(current_user.id.to_s) if current_user
  end
end
