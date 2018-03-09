require 'rails_helper'

describe Category do
	let(:category) {create(:category)}
	it_behaves_like 'a Paranoid model'

	describe 'association' do
		it {should have_many(:products)}
		it {should have_many(:category_logs).dependent(:destroy)}
		it {should belong_to(:owner).class_name('User').with_foreign_key('owner_id')}
		it {should belong_to(:user).class_name('User').with_foreign_key('user_id')}
		it {should have_many(:click_statistics)}
		it {should have_many(:dislike_statistics)}
	end

	describe 'validation' do
		it {should validate_presence_of(:name)}
		it {should validate_presence_of(:slug)}
	end

	describe 'callback' do
		it 'before_save :create_category_logs' do
			category = create(:category)
			expect(category.category_logs.count).to eq 1
		end
	end

	describe 'ransack' do
		it 'convert id to string in order to use cont predicate' do
			expect(Category.ransack(id_eq: category.id).result.to_sql).to include("to_char(\"categories\".\"id\", '99999999') = '#{category.id}'")
		end
	end
end