FactoryBot.define do
  factory :product_log do
    name FFaker::Product.model
    slug FFaker::Product.brand
  end
end
