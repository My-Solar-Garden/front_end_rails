class SessionsController < ApplicationController
  def create
    conn = Faraday.new(url: "#{ENV['RAILS_ENGINE_DOMAIN']}")
    response = conn.post('/api/v1/users', auth_hash)
    json = JSON.parse(response.body, symbolize_names: true)
    user_id = json[:data][:id]
    session[:user_id] = user_id
    flash[:notice] = 'You have successfully logged in'
    redirect_to dashboard_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
