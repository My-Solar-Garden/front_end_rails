FactoryBot.define do
  factory :sensor do
    min_threshold { Faker::Number.between(from: 1, to: 10) }
    max_threshold { Faker::Number.between(from: 10, to: 20) }
  end

    trait :moisture_sensor do
      sensor_type { 0 }
    end

    trait :light_sensor do
      sensor_type { 1 }
    end

    trait :temperature_sensor do
      sensor_type { 2 }
    end
end
