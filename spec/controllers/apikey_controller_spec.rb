require 'rails_helper'

describe ApikeyController do
	let(:admin) {create(:user, :admin)}
	it {should use_before_action(:authenticate_user!)}

	before(:each) do
		sign_in admin
	end

	describe 'GET #index' do
		it 'should show a list of apikeys' do
			apikeys = create_list(:api_key, 3)
			get :index
			expect(assigns(:apikeys)).to match_array(apikeys)
		end
	end

	describe 'POST #generate_new_api_key' do
		it 'create an api_key' do
			expect{
        post :generate_new_api_key
      }.to change(ApiKey, :count).by(1)

      expect(response).to redirect_to(action: 'index')
		end
	end
end
