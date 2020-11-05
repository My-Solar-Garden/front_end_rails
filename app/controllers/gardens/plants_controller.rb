class Gardens::PlantsController < ApplicationController
  before_action :require_user
  def show
    @plant = PlantFacade.plant_details(params[:plant_id])
  end

  def new; end
  def edit; end
  def destroy
    redirect_to garden_path
  end
end
