class Api::V1::Plants::SearchController < ApplicationController
  def index
    plants = PlantFacade.search(params[:search_term])
    render json: PlantPoroSerializer.new(plants)
  end
end