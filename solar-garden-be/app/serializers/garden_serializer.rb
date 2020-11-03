class GardenSerializer
  include FastJsonapi::ObjectSerializer
  attributes :latitude
  attributes :longitude
  attributes :name
  attributes :description
  attributes :private

  has_many :user_gardens
  has_many :users, through: :user_gardens
  has_many :sensors
  has_many :garden_plants
  has_many :plants, through: :garden_plants
end
