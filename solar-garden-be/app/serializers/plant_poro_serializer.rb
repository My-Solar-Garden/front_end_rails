class PlantPoroSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image
  attributes :name
  attributes :species
  attributes :description
  attributes :light_requirements
  attributes :water_requirements
  attributes :when_to_plant
  attributes :harvest_time
  attributes :common_pests
  attributes :id
  
end