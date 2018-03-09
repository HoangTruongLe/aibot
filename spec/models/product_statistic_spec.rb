require 'rails_helper'

RSpec.describe ProductStatistic, type: :model do
  describe 'association' do
  	it {should belong_to(:product)}
		it {should belong_to(:site)}
	end

  describe 'enum' do
		it {should define_enum_for(:statistic_type).with( [:display, :click] )}
	end
end
