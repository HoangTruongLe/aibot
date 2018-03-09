require 'rails_helper'

describe CategoryLog do
	let(:category) {create(:category)}

	describe 'association' do
		it {should belong_to(:user)}
		it {should belong_to(:category)}
	end

	it '.build_from_caterogy' do
		expect(CategoryLog.build_from_caterogy(category.as_json).attributes).to include("name" => category.name, "slug" => category.slug)
	end
end
