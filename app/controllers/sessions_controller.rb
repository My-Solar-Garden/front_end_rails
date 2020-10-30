class SessionsController < ApplicationController

  def create; end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've made an impact today.  We hope to see you again tomorrow."
    redirect_to root_path
  end
end
