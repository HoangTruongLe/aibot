FactoryBot.define do
  factory :category do
    name FFaker::Product.model
    slug FFaker::Product.brand
    tags 'example'
  end
end
