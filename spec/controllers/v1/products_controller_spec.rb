require 'rails_helper'

describe V1::ProductsController do
  let(:category_A) {create(:category, name: 'category_A')}
  let(:category_B) {create(:category, name: 'category_B')}
  let(:category_C) {create(:category, name: 'category_C')}
  let(:site) {create(:site)}
  let(:product) {create(:product, site_id: site.id)}

  before do
    request.env["HTTP_AUTHORIZATION"] = "Token token=#{site.api_key.access_token}"
  end

  it {should use_before_action(:set_product)}

  describe 'GET #index' do
    context 'in case of no params[:category]' do
      it 'should show a list of products' do
        products = create_list(:product, 3, site_id: site.id)
        get :index
        expect(assigns(:products)).to match_array(products)
      end
    end

    context 'in case of having params[:category]' do
      it 'should show a list of products that filter by category name' do
        product_A = create(:product, category_id: category_A.id, site_id: site.id)
        product_B = create(:product, category_id: category_B.id, site_id: site.id)
        product_C = create(:product, category_id: category_C.id, site_id: site.id)
        get :index, params: {category: 'A'}
        expect(assigns(:products)).to match_array(product_A)
      end
    end
  end

  describe 'GET #show' do
    it 'should show a specific product' do
      # question = create(:question, type: 3, level: 1)
      #
      # get :chatbot_show_product, params: {id: product.id}
      # expect(assigns(:close_message)).to be_a(Question)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new a product' do
        expect{
          post :create, params: { product: attributes_for(:product) }, as: :json
        }.to change(Product, :count).by(1)
        expect(JSON.parse(response.body)["status"]).to eq 'create success'
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new product' do
        expect{
          post :create, params: {product: attributes_for(:product, name: '')}, as: :json
        }.not_to change(Product, :count)
        expect(JSON.parse(response.body)["status"]).to eq 'create fail'
      end
    end
  end

  describe 'PATCH #update' do
    it 'in case of succeed' do
      patch :update, params: {id: product.id, product: {name: 'update_name', slug: 'update_slug'}}, as: :json
      product.reload
      expect(product.name).to eq 'update_name'
      expect(product.slug).to eq 'update_slug'
      expect(JSON.parse(response.body)["status"]).to eq 'update success'
    end

    it 'in case of fail' do
      patch :update, params: {id: product.id, product: {name: '', slug: ''}}, as: :json
      expect(JSON.parse(response.body)["status"]).to eq 'update fail'
    end
  end

  describe 'DELETE #destroy' do
    it 'in case of success' do
      expect {
        delete :destroy, params: {id: product.id}, as: :json
      }.to change(Product, :count).by(0)
      expect(JSON.parse(response.body)["status"]).to eq 'delete success'
    end

    it 'in case of fail' do
      delete :destroy, params: {id: 9999999}, as: :json
      expect(JSON.parse(response.body)["status"]).to eq 'delete fail'
    end
  end
end
