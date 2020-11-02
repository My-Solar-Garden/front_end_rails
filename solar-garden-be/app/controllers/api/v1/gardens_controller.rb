class Api::V1::GardensController < ApplicationController
  def index
    return nil if Garden.all.empty?
    render json: GardenSerializer.new(Garden.all)
  end

  def show
    return nil if !Garden.exists?(params[:id])
    render json: GardenSerializer.new(Garden.find(params[:id]))
  end

  def create
    user = User.find(params[:user_id])
    new_garden = user.gardens.create(garden_params)
    render json: GardenSerializer.new(new_garden) if new_garden.save
  end

  def update
    return nil if !Garden.exists?(params[:id])
    render json: GardenSerializer.new(Garden.update(params[:id], garden_params))
  end

  def destroy
    return nil if !Garden.exists?(params[:id])
    Garden.destroy(params[:id])
  end

  private
  def garden_params
    params.permit(:latitude, :longitude, :name, :private, :description)
  end
end
