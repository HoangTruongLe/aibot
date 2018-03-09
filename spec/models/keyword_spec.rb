require 'rails_helper'

describe Keyword do
	let(:keyword) {create(:keyword)}

	describe 'association' do
		it {should belong_to(:master_category)}
	end

  describe 'validation' do
		it {should validate_presence_of(:name)}
	end

end
