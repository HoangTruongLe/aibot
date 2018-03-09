# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Site.all.size == 0
  Site.create(name: "Testing Site", site_url: "http://localhost:3000")
end

if User.all.size == 0
  role = Role.create(name: 'admin')
  User.create(email: 'admin@example.com', password: '12345678', name: 'Admin', role_ids: [role.id])
  User.create(email: 'user@example.com', password: '12345678', name: 'User', site_ids: [Site.first.id])
end

if ChatbotEmotion.all.size == 0
  ChatbotEmotion.create(:emotion => "普通")
  ChatbotEmotion.create(:emotion => "微笑み")
  ChatbotEmotion.create(:emotion => "怒り")
  ChatbotEmotion.create(:emotion => "疑問の顔")
end

Setting.create!(meta_key: 'main_key_weight', meta_value: '1.0') if Setting.where(meta_key: 'main_key_weight').size == 0
Setting.create!(meta_key: 'relative_key_weight', meta_value: '0.6') if Setting.where(meta_key: 'relative_key_weight').size == 0


if Rails.env.development?
  CustomerInformation.create!(session_statistic_id: rand(9999),
                              zipcode: Faker::Code.isbn,
                              prefecture: Faker::Ancient.primordial,
                              municipality: Faker::AquaTeenHungerForce.character,
                              street: Faker::StarWars.specie,
                              building: Faker::StarWars.planet,
                              name: Faker::Name.first_name,
                              email: Faker::Internet.email,
                              phone: Faker::PhoneNumber.phone_number)
end
