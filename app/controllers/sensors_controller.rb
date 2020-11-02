class SensorsController < ApplicationController
  before_action :require_user

  def show
    @sensor = GardenFacade.sensor_details
    require "pry"; binding.pry
  end

  def new; end
  def edit; end
  def destroy
    redirect_to dashboard_path
  end
end
