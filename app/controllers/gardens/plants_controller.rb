class Gardens::PlantsController < ApplicationController
  def create
    PlantFacade.add_plant_to_garden(params)
    redirect_to "/gardens/#{params[:id]}"
  end
end
