class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email

  has_many :user_gardens
  has_many :gardens, through: :user_gardens
end
