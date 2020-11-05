class SensorsController < ApplicationController
  # before_action :require_user

  def show
    @sensor = SensorFacade.sensor_details(params)
    if params['history']
      stop = DateTime.now.to_s[0..9]
      start = (DateTime.now - params['history'].to_i).to_s[0..9]
      @history = GardenHealthFacade.garden_health_search(start, stop, @sensor.id)
    end
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
    SensorFacade.delete_sensor(params)
    redirect_back(fallback_location: dashboard_path)
  end

  private
  def sensor_params
    params.permit(:sensor_type, :min_threshold, :max_threshold, :garden_id)
  end
end
