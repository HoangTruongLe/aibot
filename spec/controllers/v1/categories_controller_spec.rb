require 'rails_helper'

describe V1::CategoriesController do
  let(:category) {create(:category)}
  
  before(:each) do
    allow(@controller).to receive(:restrict_access).and_return(true)
  end

  describe 'GET #index' do
    it 'list categories from api' do
      categories = create_list(:category, 3)

      get :index
      expect(assigns(:categories)).to match_array(categories)
    end
  end

  describe 'GET #show' do
    it 'should show a specific category' do
      get :show, params: {id: category.id}
      expect(assigns(:category)).to be_a(Category)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new a category' do
        expect{
          post :create, params: {category: attributes_for(:category)}, as: :json
        }.to change(Category, :count).by(1)
        expect(JSON.parse(response.body)["status"]).to eq 'create success'
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new category' do
        expect{
          post :create, params: {category: attributes_for(:category, name: '')}, as: :json
        }.not_to change(Category, :count)
        expect(JSON.parse(response.body)["status"]).to eq 'create fail'
      end
    end
  end

  describe 'PATCH #update' do
    it 'in case of succeed' do
      patch :update, params: {id: category.id, category: {name: 'update_name', slug: 'update_slug'}}, as: :json
      category.reload

      expect(category.name).to eq 'update_name'
      expect(category.slug).to eq 'update_slug'
      expect(JSON.parse(response.body)["status"]).to eq 'update success'
    end

    it 'in case of fail' do
      patch :update, params: {id: category.id, category: {name: '', slug: ''}}, as: :json
      expect(JSON.parse(response.body)["status"]).to eq 'update fail'
    end
  end

  describe 'DELETE #destroy' do
    it 'in case of success' do
      expect {
        delete :destroy, params: {id: category.id}, as: :json
      }.to change(Category, :count).by(0)
      expect(JSON.parse(response.body)["status"]).to eq 'delete success'
    end

    it 'in case of fail' do
      delete :destroy, params: {id: 9999999}, as: :json
      expect(JSON.parse(response.body)["status"]).to eq 'delete fail'
    end
  end
end
