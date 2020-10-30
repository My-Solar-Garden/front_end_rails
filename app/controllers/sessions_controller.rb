class SessionsController < ApplicationController
  def create
    if auth_hash["credentials"] == nil
      render 'Google Authorization was unable to be completed.'
      redirect_to root_path
    end
    if auth_hash["credentials"]  
      render 'You have successfully logged in.'
    end 
  end

  private
  
  def auth_hash
    request.env["omniauth.auth"]
  end 
end

