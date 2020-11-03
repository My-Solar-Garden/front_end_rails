FactoryBot.define do
  factory :plant do
     image { 'image.url' }
     name { Faker::FunnyName.name }
     species { 'some latin malarky' }
     description { 'very plant-like' }
     light_requirements { 'Its a plant, needs a bunch of light yo' }
     water_requirements { 'Its a plant, needs a bunch of water yo' }
     when_to_plant { 'On the 5th new moon of the year' }
     harvest_time { 'When sun is short in the sky and the dark takes over' }
     common_pests { 'buncha lil jerks' }
  end
end
