require 'rails_helper'

describe HomeController do
  let(:admin) {create(:user, :admin)}

  before(:each) do
		sign_in admin
	end

	describe 'GET #user_profile' do
		it 'should show a current_user' do
			get :user_profile
			expect(assigns(:user)).to eq(admin)
		end
	end

	# describe 'PATCH #update_user' do
	# 	it 'in case of succeed' do
	# 		patch :update_user, params: {id: admin.id, user: attributes_for(:user, name: 'updated_name')}
	# 		admin.reload
  #
	# 		expect(admin.name).to eq 'updated_name'
	# 		expect(flash[:notice]).to be_present
	# 		expect(response).to redirect_to(profile_path)
	# 	end
  #
	# 	it 'in case of failure' do
	# 		patch :update_user, params: {id: admin.id, user: attributes_for(:user, name: '')}
	# 	  expect(response).to render_template :user_profile
	# 	end
	# end
end
