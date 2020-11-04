class SensorsController < ApplicationController
  before_action :require_user
  def show; end

  def new
    @garden_id = params[:garden_id]
  end

  def create
    @garden_id = params[:garden_id]
    SensorFacade.new_sensor(sensor_params)
    redirect_to "/gardens/#{@garden_id}"
  end

  def edit; end

  def destroy
    require "pry"; binding.pry
    SensorFacade.delete_sensor(params)
    # redirect_back(fallback_location: dashboard_path)
    redirect_to garden_path(params[:id])
  end

  private
  def sensor_params
    params.permit(:sensor_type, :min_threshold, :max_threshold, :garden_id)
  end
end
