FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    provider { 'Google' }
    token { '123fdf12sdsd3bkj2eb2' }
    uid { '98764'}
  end
end
