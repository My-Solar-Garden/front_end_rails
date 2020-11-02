class SensorsController < ApplicationController
  before_action :require_user
  def show; end

  def new
    @garden_id = params[:garden_id]
  end

  def create
    conn = Faraday.new(:url => "https://solar-garden-be.herokuapp.com/api/v1/sensors")
    binding.pry
    conn.post do |req|
      req.url 'https://solar-garden-be.herokuapp.com/api/v1/sensors'
      req.headers['Content-Type'] = 'application/json'
    end

    # req.body = '{"sensor_type":0, "min_threshold":5, "max_threshold":10, "garden_id":1}'
    # req.body = sensor_params.to_s
    # req.body = "{'sensor_type': #{params[:sensor_type]}, 'min_threshold': #{params[:min_threshold]}, 'max_threshold': #{params[:max_threshold]}, 'garden_id': #{params[:garden_id]}}"

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
