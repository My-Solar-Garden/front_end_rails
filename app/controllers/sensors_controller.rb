class SensorsController < ApplicationController
  before_action :require_user
  def show; end
  def new; end
  def edit; end
  def destroy
    redirect_to dashboard_path
  end
end
