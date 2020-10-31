require 'google/api_client/client_secrets.rb'

class SessionsController < ApplicationController
  def create
    conn = Faraday.new(url: "http://localhost:3000")
    response = conn.post('/api/v1/users', auth_hash)
    json = JSON.parse(response.body, symbolize_names: true)
    user = User.new(json[:data])
    session[:user_id] = user.id
    flash[:notice] = 'You have successfully logged in'
    redirect_to dashboard_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
