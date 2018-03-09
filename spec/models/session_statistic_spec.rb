require 'rails_helper'

describe SessionStatistic do
	let(:session_statistic) {create(:session_statistic)}

	describe 'validation' do
		it {should validate_presence_of(:session_key)}
	end

end
