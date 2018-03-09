FactoryBot.define do
  factory :user do
		sequence :email do |n|
    	"neolab-#{n}@example.com"
  	end 
		name FFaker::Name.name 
		password 'password'
		password_confirmation 'password'
		
		trait :admin do
			after(:create) {|user| user.add_role(:admin)}
		end
  end
end
