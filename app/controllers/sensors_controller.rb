class SensorsController < ApplicationController
  before_action :require_user

  def show
    @sensor = SensorFacade.sensor_details(params)
    @last_five_readings = @sensor.garden_healths.reverse.take(5).map { |reading| reading.reading }
      @last_five_readings = @last_five_readings.reverse
    if params['history']
      stop = DateTime.now.to_s[0..9]
      start = (DateTime.now - params['history'].to_i).to_s[0..9]
      @previous_readings = GardenHealthFacade.garden_health_search(start, stop, @sensor.id).map { |reading| reading.reading }
    end
    @type = determine_type(@sensor)
  end

  def new
    @garden_id = params[:garden_id]
  end

  def create
    @garden_id = params[:garden_id]
    SensorFacade.new_sensor(sensor_params)
    redirect_to "/gardens/#{@garden_id}"
  end

  def edit
    @sensor = SensorFacade.sensor_details(params)
  end

  def update
    SensorFacade.edit_sensor(sensor_params)
    redirect_to "/gardens/#{params[:garden_id]}"
  end

  def destroy
    SensorFacade.delete_sensor(params)
    redirect_back(fallback_location: dashboard_path)
  end

  private
  def sensor_params
    params.permit(:sensor_type, :min_threshold, :max_threshold, :garden_id)
  end

  def determine_type(sensor)
    if sensor.sensor_type == 'light'
      "light %"
    elsif sensor.sensor_type == 'temperature'
      "temperature (C°)"
    end
  end
end
