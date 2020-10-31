class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :require_user

  def current_user
    @current_user 
  end

  def require_user
    render file: "/public/404" unless current_user
  end
end
