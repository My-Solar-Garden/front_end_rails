class UserGarden < ApplicationRecord
  belongs_to :user
  belongs_to :garden
end
