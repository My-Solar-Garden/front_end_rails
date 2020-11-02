class Sensor < ApplicationRecord
  validates :min_threshold, :max_threshold, :sensor_type, :garden_id, presence: true
  validates :min_threshold, :max_threshold, numericality: true

  belongs_to :garden
  has_many :garden_healths

  enum sensor_type: %w(moisture light temperature)

  def search_readings_between_dates(start, stop)
    garden_healths
      .where(garden_healths: {created_at: "#{start} 00:00:00".."#{stop} 23:59:59"})
  end
end
