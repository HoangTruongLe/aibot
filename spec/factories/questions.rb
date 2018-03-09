FactoryBot.define do
  factory :question do
    content FFaker::Lorem.phrase
    keyword "example"

    trait :type_is_open do
    	type 'オープンメッセージ'
    end
    trait :type_is_middle do
    	type 'ミドルメッセージ'
    end
    trait :type_is_close do
    	type 'クロージングメッセージ'
    end

    trait :level_is_list_products do
    	level 'list_product'
    end
    trait :level_is_product do
    	level 'product'
    end
  end
end
