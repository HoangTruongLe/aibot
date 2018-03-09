require 'rails_helper'

describe ApiKey do
	describe 'callback' do
		it 'before_create :generate_access_token' do
			api_key = create(:api_key)
			expect(api_key.access_token).not_to eq nil
		end
	end
end