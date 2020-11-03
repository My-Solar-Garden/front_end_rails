class SensorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :min_threshold, :max_threshold, :sensor_type

  belongs_to :garden
  has_many :garden_healths
end
