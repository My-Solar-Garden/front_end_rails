class DashboardController < ApplicationController
  before_action :require_user

  def require_user
    render file: "/public/404" unless current_user
  end

  def show

  end
end
