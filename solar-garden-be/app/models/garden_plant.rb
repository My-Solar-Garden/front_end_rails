class GardenPlant < ApplicationRecord
  validates :planted_date, presence: true

  belongs_to :garden
  belongs_to :plant
end
