require 'rails_helper'

describe ClickStatistic do
	describe 'association' do
		it {should belong_to(:clicked)}
	end
end
