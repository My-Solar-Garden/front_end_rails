class UsersController < ApplicationController
  before_action :require_user

  def show; end

  def update
    Faraday.patch("#{ENV['BE_URL']}/api/v1/users/#{current_user.id}") do |req|
      req.headers['CONTENT_TYPE'] = "application/json"
      req.params['id'] = params[:id].as_json
      req.params['update_user'] = { email: params[:email] }
    end
    redirect_to profile_path
  end

  def destroy
    Faraday.delete("#{ENV['BE_URL']}/api/v1/users/#{current_user.id}")
    session[:user_id] = nil
    flash[:success] = "Successfully deleted account"
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:id, :email)
  end
end
