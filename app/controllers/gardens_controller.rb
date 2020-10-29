class GardensController < ApplicationController
  before_action :require_user

  def index; end

  def new; end

  def edit; end

  def destroy
    redirect_to gardens_path
  end
end
