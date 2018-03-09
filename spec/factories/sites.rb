FactoryBot.define do
  factory :site do
    name Faker::DragonBall.character
    site_url FFaker::Internet.http_url
  end
end
