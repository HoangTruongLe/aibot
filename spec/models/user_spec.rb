require 'rails_helper'

describe User do
	# let(:user) {create(:user, :admin)}

	# describe 'association' do
	# 	it {should have_many(:category_logs).dependent(:destroy)}
	# 	it {should have_many(:product_logs).dependent(:destroy)}
	# 	it {should have_many(:owner_categories).class_name('Category').with_foreign_key('owner_id').dependent(:destroy)}
	# 	it {should have_many(:user_categories).class_name('Category').with_foreign_key('user_id').dependent(:destroy)}
	# 	it {should have_many(:owner_products).class_name('Product').with_foreign_key('owner_id').dependent(:destroy)}
	# 	it {should have_many(:user_products).class_name('Product').with_foreign_key('user_id').dependent(:destroy)}
	# 	it {should have_many(:sites).dependent(:destroy)}
	# end
	#
	# describe 'validation' do
	# 	it { should validate_presence_of(:name) }
	# end
	#
	# it '#admin?' do
	# 	expect(user.admin?).to eq true
	# end
	#
	# describe 'callback' do
	# 	it 'after_create :assign_default_role' do
	# 		user = create(:user)
	# 		expect(user.has_role? :manager).to eq true
	# 	end
	# end
end
