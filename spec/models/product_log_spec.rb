require 'rails_helper'

describe ProductLog do
	let(:category) {create(:category)}
	let(:product) {create(:product, category_id: category.id)}
	
	describe 'association' do
		it {should belong_to(:product)}
	end

	it '.build_from_caterogy' do
		expect(ProductLog.build_from_product(product.as_json).attributes).to include("name" => product.name, "slug" => product.slug)
	end
end
