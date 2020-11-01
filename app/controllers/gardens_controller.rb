class GardensController < ApplicationController
  before_action :require_user, except: [:show]


  def show
    # move conn, response, parse to service and facade once we better udnerstand api response structure
    conn = Faraday.new("https://solar-garden-be.herokuapp.com/api/v1/gardens/#{params[:id]}")
    response = conn.get
    parsed = JSON.parse(response.body, symbolize_names: true)
    garden = Garden.new(parsed[:data])
    @sensors = garden.sensors.map { |sensor| Sensor.new(sensor)  }

    if !garden.is_private || current_users_garden?(garden)
      @garden = garden
    else
      render_404
    end
  end

  def new; end

  def create
    # POST "api/v1/gardens" to create a garden using strong params
    # note pass in current_user.id into hash for back-end association
    redirect_to dashboard_path
  end

  def edit
    # GET "api/v1/gardens/params[:id]" to obtain garden from id

              # this code is used only for testing
    @garden = Garden.new(current_user.gardens.first)
  end

  def update
    # PATCH "api/v1/gardens/params[:id]" to update the garden using strong params
    redirect_to dashboard_path
  end

  def destroy
    # DELETE api/v1/gardens/:id' to destroy garden
    redirect_to dashboard_path
  end

  private

  def garden_params
    params.permit(:name, :latitude, :longitude, :private, :description)
  end

  def current_users_garden?(garden)
      garden.user_ids.include?(current_user.id.to_s) if current_user
  end
end
