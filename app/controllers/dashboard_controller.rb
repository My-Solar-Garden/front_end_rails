class DashboardController < ApplicationController
  before_action :require_user

  def show
    @gardens = GardenFacade.create_garden_objects(current_user.gardens)
    @weather = WeatherFacade.create_weather_objects(current_user.location)
  end
end
