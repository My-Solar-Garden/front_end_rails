class SensorsController < ApplicationController
  before_action :require_user
  def show; end
  def new
  end
  def create
    redirect_to dashboard_path
  end
  def edit; end
  def destroy
    redirect_to dashboard_path
  end
end
