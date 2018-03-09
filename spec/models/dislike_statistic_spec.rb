require 'rails_helper'

describe DislikeStatistic do
	describe 'association' do
  	it {should belong_to(:dislike)}
  end
end
