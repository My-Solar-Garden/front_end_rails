class GardenHealth < ApplicationRecord
  validates :reading_type, :reading, presence: true
  validates :reading, numericality: true

  belongs_to :sensor, optional: true

  enum reading_type: %w(moisture light)
end
