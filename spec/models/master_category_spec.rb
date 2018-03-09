require 'rails_helper'

describe MasterCategory do
	let(:category) {create(:category)}

	describe 'association' do
		it {should belong_to(:parent)}
		it {should have_many(:childs)}
		it {should have_many(:keywords)}
	end

  describe 'validation' do
		it {should validate_presence_of(:name)}
	end

end
