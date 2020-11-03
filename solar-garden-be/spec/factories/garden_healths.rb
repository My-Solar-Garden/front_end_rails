FactoryBot.define do
  factory :garden_health do
    sensor
    reading_type { [0, 1].sample }
    reading { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    time_of_reading { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
