class SensorsController < ApplicationController
  before_action :require_user

  def show
    @sensor = SensorFacade.sensor_details(params)
  end

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
    redirect_to dashboard_path
  end

  private
  def sensor_params
    params.permit(:sensor_type, :min_threshold, :max_threshold, :garden_id)
  end
end
