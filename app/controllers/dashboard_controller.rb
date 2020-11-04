class DashboardController < ApplicationController
  before_action :require_user
  
  def show
    @gardens = GardenFacade.create_garden_objects(current_user.gardens)
  end
end
