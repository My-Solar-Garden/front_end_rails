class GardenHealthSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :reading_type, :reading, :created_at
end
