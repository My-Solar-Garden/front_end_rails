FactoryBot.define do
  factory :garden do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    name { Faker::FunnyName.name }
    private { false }
  end
end
