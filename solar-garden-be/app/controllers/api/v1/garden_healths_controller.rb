class Api::V1::GardenHealthsController < ApplicationController
  def index
    return nil if GardenHealth.all.empty?
    render json: GardenHealthSerializer.new(GardenHealth.all)
  end

  def show
    return nil if !GardenHealth.exists? params[:id]
    render json: GardenHealthSerializer.new(GardenHealth.find(params[:id]))
  end

  def create
    new_record = GardenHealth.new(garden_health_params)
    render json: GardenHealthSerializer.new(new_record) if new_record.save
  end

  def update
    return nil if !GardenHealth.exists? params[:id]
    updated_record = GardenHealth.find(params[:id])
    updated_record.attributes = garden_health_params
    render json: GardenHealthSerializer.new(updated_record) if updated_record.save
  end

  def destroy
    return nil if !GardenHealth.exists? params[:id]
    GardenHealth.destroy(params[:id])
  end

  private

  def garden_health_params
    params.permit(:sensor_id, :reading_type, :reading, :time_of_reading)
  end
end
