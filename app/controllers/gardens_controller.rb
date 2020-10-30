class GardensController < ApplicationController
  before_action :require_user

  def new; end

  def create
    # hit the POST api/v1/gardens API to create a garden using strong params
    # note pass in current_user.id into hash for back-end association
    redirect_to dashboard_path
  end

  def edit
    # GET "api/v1/gardens/params[:id]" to obtain garden from id

              # this code is used only for testing
    @garden = Garden.new(current_user.gardens.first)
  end

  def destroy
    redirect_to dashboard_path
  end

  private

  def garden_params
    params.permit(:name, :latitude, :longitude, :private, :description)
  end
end
