class SessionsController < ApplicationController
  def create
    binding.pry
    @user = User.find_by(email: auth_hash)
    self.current_user = @user
    redirect_to '/dashboard'
  end

    protected

  def auth_hash
    request.env['omniauth.auth']['info']['email']
  end
end