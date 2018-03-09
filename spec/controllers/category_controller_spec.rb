require 'rails_helper'

describe CategoriesController do
	let(:user) {create(:user)}
  let(:admin) {create(:user, :admin)}
	let(:category) {create(:category)}
	let(:category_log) {create(:category_log, user_id: user.id, category_id: category.id)}

	it {should use_before_action(:authenticate_user!)}
	it {should use_before_action(:set_category)}
	it {should use_before_action(:set_category_log)}
	it {should use_before_action(:add_categories_index_path)}

	before(:each) do
		sign_in admin
	end

	describe 'GET #index' do
		it 'should show a list of categories' do
			categories = create_list(:category, 3)

			get :index
			expect(assigns(:categories)).to match_array(categories)
		end
	end

	describe 'GET #show' do
		it 'should show a specific category' do
			get :show, params: {id: category.id}
			expect(assigns(:category)).to eq(category)
		end
	end

	describe 'GET #new' do
		it 'create a new category' do
			get :new
    	expect(assigns(:category)).to be_a_new(Category)
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'creates a new category' do
	      expect{
	        post :create, params: {category: attributes_for(:category)}
	      }.to change(Category, :count).by(1)

	      expect(response).to redirect_to(categories_path)
	    end
		end

		context 'with invalid attributes' do
			it 'does not save the new category' do
	      expect{
	        post :create, params: {category: attributes_for(:category, name: '', slug: '')}
	      }.to_not change(Category, :count)
	    end

	    it 'render to new action' do
	      post :create, params: {category: attributes_for(:category, name: '', slug: '')}
	      expect(response).to render_template :new
	    end
		end
	end

	describe 'GET #edit' do
		it 'should edit a specific category' do
			get :edit, params: {id: category.id}
			expect(assigns(:category)).to eq(category)
		end
	end

	describe 'PUT #update' do
		it 'in case of succeed' do
			put :update, params: {id: category.id, category: attributes_for(:category, name: 'updated_name', slug: 'updated_slug')}
			category.reload

			expect(category.name).to eq 'updated_name'
			expect(category.slug).to eq 'updated_slug'
			expect(flash[:notice]).to be_present
			expect(response).to redirect_to(categories_path)
		end

		it 'in case of failure' do
			put :update, params: {id: category.id, category: attributes_for(:category, name: '')}
		  expect(response).to render_template :new
		end
	end

	describe 'DELETE #destroy' do
		it 'should destroy a category' do
			expect{ 
		    delete :destroy, params: {id: category.id}
		  }.to change(Category, :count).by(0)

			expect(flash[:notice]).to be_present
			expect(response).to redirect_to(categories_path)
		end
	end

	describe 'GET #logs' do
		it 'should show a list of category_logs' do
			category_logs = category.category_logs

			get :logs, params: {id: category.id}
			expect(assigns(:category_logs)).to match_array(category_logs)
		end
	end

	describe 'GET #show_log' do
		it 'should show a categroy log' do
			get :show_log, params: {id: category_log.id}
			expect(assigns(:category_log)).to eq(category_log)
		end
	end
end