class Gardens::PlantsController < ApplicationController
  before_action :require_user
  def show
    @plant = PlantFacade.plant_details(params[:id])
  end

  def new; end
  def edit; end
  def destroy
    redirect_to dashboard_path
  end
end
