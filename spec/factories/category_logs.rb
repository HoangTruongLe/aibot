FactoryBot.define do
  factory :category_log do
  	name FFaker::Product.model
  	slug FFaker::Product.brand
		user
		category    
  end
end
