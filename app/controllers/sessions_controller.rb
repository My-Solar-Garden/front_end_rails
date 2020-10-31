class SessionsController < ApplicationController

  #we recognize these may not look the same once OAuth is in place, but we put them in place to attempt to test with them.  Turns out if you do the ApplicationController shortcut to make :current_user equal @user, then even if you do the destroy action, there isn't really a way to destroy the session.

  def create;end

  def destroy
    #session[:user_id] = nil
    flash[:success] = "You've made an impact today.  We hope to see you again tomorrow."
    redirect_to root_path
  end
end
