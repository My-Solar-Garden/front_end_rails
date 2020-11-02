class Api::V1::UsersController < ApplicationController
  def index
    return nil if User.all.empty?
    render json: UserSerializer.new(User.all)
  end

  def show
    return nil if !User.exist?(params[:id])
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def create
    user = User.from_onmiauth(user_params)
    return nil if !user.save
    render json: UserSerializer.new(user)
  end

  def update
    return nil if !User.exist?(params[:id])
    render json: UserSerializer.new(User.update(params[:id], user_params))
  end

  def destroy
    return nil if !User.exist?(params[:id])
    User.destroy(params[:id])
  end

  private

  def user_params
    if params[:update_user]
      params.require(:update_user).permit(:email)
    else
      a = params.permit(:uid, :provider)
      b = params.require(:credentials).permit(:token, :refresh_token)
      c = params.require(:info).permit(:email)
      a.merge(b).merge(c)
    end
  end
end
