class SessionsController < ApplicationController
  def create
    conn = Faraday.new(url: "https://solar-garden-be.herokuapp.com")
    response = conn.post('/api/v1/users', auth_hash)
    json = JSON.parse(response.body, symbolize_names: true)
    user = User.new(json[:data])
    session[:user_id] = user.id
    flash[:notice] = 'You have successfully logged in'
    redirect_to dashboard_path
  end

  def destroy
    #session[:user_id] = nil
    flash[:success] = "You've made an impact today.  We hope to see you again tomorrow."
    redirect_to root_path
  end 
  
  private

  def auth_hash
    request.env["omniauth.auth"]
  end 
end
