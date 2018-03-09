FactoryBot.define do
  factory :product do
    name FFaker::Product.model
    slug FFaker::Product.brand
    description "説明 を入力してください"
    site
  end
end
