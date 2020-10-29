class UsersController < ApplicationController
  before_action :require_user
  def show; end
  def destroy
    redirect_to root_path
  end
end
