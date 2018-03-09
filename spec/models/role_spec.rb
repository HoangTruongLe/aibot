require 'rails_helper'

describe Role do
	describe 'association' do
		it {should have_and_belong_to_many(:users).join_table('users_roles')}
		it {should belong_to(:resource)}
	end

	describe 'validation' do
	  it {should validate_inclusion_of(:resource_type).in_array(Rolify.resource_types)}
	  it {should allow_value(nil).for(:resource_type)}
	end
end