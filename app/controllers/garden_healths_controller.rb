class GardenHealthsController < ApplicationController
  before_action :require_user

  def show
    @garden_healths = GardenHealthFacade.garden_health_search(params['start'], params['stop'], params['sensor_id'])
  end
end
