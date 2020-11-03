class Api::V1::SearchController < ApplicationController
  def index
    return nil if params['start'].nil? || params['stop'].nil? || params['sensor_id'].nil?
    start = params['start']
    stop = params['stop']
    sensor = Sensor.find(params['sensor_id'])
    render json: GardenHealthSerializer.new(sensor.search_readings_between_dates(start, stop))
  end
end
