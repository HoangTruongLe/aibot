require 'rails_helper'

describe Product do
	let(:user) {create(:user)}
	let(:category) {create(:category)}
	let(:product) {create(:product)}
	let(:product_user) {create(:product, user_id: user.id)}
	let(:product_owner) {create(:product,owner_id: user.id)}

  it_behaves_like 'a Paranoid model'

  describe 'association' do
  	it {should belong_to(:category)}
		it {should have_many(:click_statistics)}
		it {should have_many(:dislike_statistics)}
		it {should have_many(:product_logs)}
		it { should belong_to(:site) }
		it { should have_many(:product_statistics) }
		it { should have_many(:product_reports) }
		it { should have_many(:cv_transactions) }
		it {should belong_to(:owner).class_name('User').with_foreign_key('owner_id')}
		it {should belong_to(:user).class_name('User').with_foreign_key('user_id')}
	end

	describe 'validation' do
		it {should validate_presence_of(:name)}
		it {should validate_presence_of(:slug)}
		it {should validate_presence_of(:description)}
	end

	describe 'callback' do
		it 'before_save :create_product_logs' do
			product = create(:product, category_id: category.id, user_id: user.id, owner_id: user.id)
			expect(product.product_logs.count).to eq 1
		end
	end

	describe 'ransack' do
		it 'convert id to string in order to use cont predicate' do
			expect(Product.ransack(id_eq: product.id).result.to_sql).to include("to_char(\"products\".\"id\", '99999999') = '#{product.id}'")
		end
	end

	it '.products_by_category' do
		category = create(:category, name: 'test')
		expect(Product.products_by_category('es').to_sql).to include("categories.name LIKE '%es%')")
	end

	describe '.to_csv' do
		before(:each) do
			@products = create_list(:product, 3)
			@csv_content = Product.to_csv
		end

		it 'desired_columns' do
			Product.csv_columns.map do |field_name|
				expect(@csv_content).to include(I18n.t field_name, scope: [:activerecord, :attributes, :product])
			end
		end

		it 'output csv' do
			@products.each do |product|
				expect(@csv_content.split(',').reject(&:empty?)).to include(product.attributes["slug"])
			end
		end
	end

	it '#user' do
		expect(product_user.user).to eq user.name
	end

	it '#owner' do
		expect(product_owner.owner).to eq user.name
	end
end
