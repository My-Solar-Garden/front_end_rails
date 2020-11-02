class UsersController < ApplicationController
  before_action :require_user

  def show; end

  def update
    UserFacade.update_email(current_user.id, params[:email])
    redirect_to profile_path
  end

  def destroy
    UserFacade.delete_user(current_user.id)
    session[:user_id] = nil
    flash[:success] = "Successfully deleted account"
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:id, :email)
  end
end
