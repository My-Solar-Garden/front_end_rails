class Api::V1::PlantsController < ApplicationController
  def index
    return nil if Plant.all.empty?
    render json: PlantSerializer.new(Plant.all)
  end

  def show
    return nil if !Plant.exists?(params[:id])
    render json: PlantSerializer.new(Plant.find(params[:id]))
  end

  def create
    new_plant = Plant.new(plant_params)
    render json: PlantSerializer.new(new_plant) if new_plant.save
  end

  def update
    return nil if !Plant.exists?(params[:id])
    render json: PlantSerializer.new(Plant.update(params[:id], plant_params))
  end

  def destroy
    return nil if !Plant.exists?(params[:id])
    Plant.destroy(params[:id])
  end

  private
  def plant_params
    params.permit(:image, :name, :species, :description, :light_requirements, :water_requirements, :when_to_plant, :harvest_time, :common_pests)
  end
end
