class GardensController < ApplicationController
  before_action :require_user, except: [:show]

  def index; end

  def show
    garden = GardenFacade.garden_details(params)
    @sensors = garden.sensors.map { |sensor| Sensor.new(sensor)  }

    if !garden.is_private || current_users_garden?(garden)
      @garden = garden
    else
      render_404
    end
  end

  def new; end

  def create
    GardenFacade.new_garden(garden_params, current_user.id)
    redirect_to gardens_path
  end

  def edit
    # GET "api/v1/gardens/params[:id]" to obtain garden from id

              # this code is used only for testing
    @garden = Garden.new(current_user.gardens.first)
  end

  def update
    # PATCH "api/v1/gardens/params[:id]" to update the garden using strong params
    redirect_to gardens_path
  end

  def destroy
    # DELETE api/v1/gardens/:id' to destroy garden
    redirect_back(fallback_location: dashboard_path)
  end

  private

  def garden_params
    params.permit(:name, :latitude, :longitude, :private, :description)
  end

  def current_users_garden?(garden)
    garden.user_ids.include?(current_user.id.to_s) if current_user
  end
end
