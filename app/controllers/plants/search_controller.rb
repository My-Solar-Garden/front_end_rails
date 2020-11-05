class Plants::SearchController < ApplicationController

  def index
    @garden_id = request.env["HTTP_REFERER"].split('/').last
    @plants = PlantFacade.search_plants(params[:search_term])
  end

end