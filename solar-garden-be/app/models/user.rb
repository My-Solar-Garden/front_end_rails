class User < ApplicationRecord
  validates :email, :provider, :token, :uid, presence: true

  has_many :user_gardens
  has_many :gardens, through: :user_gardens

  def self.exist?(id)
    find(id) rescue false
  end

  def self.from_onmiauth(user_params)
    user = find_or_create_by(uid: user_params[:uid])
    user.email = user_params[:email]
    user.provider = user_params[:provider]
    user.token = user_params[:token]
    user.refresh_token = user_params[:refresh_token]
    user.save
    user
  end
end
