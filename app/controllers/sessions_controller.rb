class SessionsController < ApplicationController
  def create
    user = SessionFacade.session_details(auth_hash)
    session[:user_id] = user.id
    flash[:notice] = 'You have successfully logged in'
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've made an impact today.  We hope to see you again tomorrow."
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
