require 'rails_helper'

describe ProductsController do
	let(:user) {create(:user)}
  let(:admin) {create(:user, :admin)}
  let(:site) {create(:site)}
	let(:product) {create(:product, site_id: site.id, user_id: user.id, owner_id: user.id)}
  let(:product_log) {create(:product_log, user_id: user.id, product_id: product.id, site_id: site.id)}

	it {should use_before_action(:authenticate_user!)}
	it {should use_before_action(:set_product)}
	it {should use_before_action(:add_products_index_path)}
	it {should use_before_action(:set_product_log)}

	before(:each) do
		sign_in admin
	end

	describe 'GET #index' do
		it 'should show a list of products' do
			products = create_list(:product, 3)

			get :index
			expect(assigns(:products)).to match_array(products)
		end
	end

	describe 'GET #show' do
		it 'should show a specific product' do
			get :show, params: {id: product.id}
			expect(assigns(:product)).to eq(product)
		end
	end

	describe 'GET #edit' do
		it 'should edit a specific product' do
			get :edit, params: {id: product.id}
			expect(assigns(:product)).to eq(product)
		end
	end

	describe 'PUT #update' do
		it 'in case of succeed' do
			put :update, params: {id: product.id, product: attributes_for(:product, name: 'updated_name', slug: 'updated_slug')}
			product.reload

			expect(product.name).to eq 'updated_name'
			expect(product.slug).to eq 'updated_slug'
			expect(flash[:notice]).to be_present
			expect(response).to redirect_to(products_path)
		end

		it 'in case of failure' do
			put :update, params: {id: product.id, product: attributes_for(:product, name: '')}
		  expect(response).to render_template :edit
		end
	end

	describe 'DELETE #destroy' do
		it 'should destroy a product' do
			expect{
		    delete :destroy, params: {id: product.id}
		  }.to change(Product, :count).by(0)

			expect(flash[:notice]).to be_present
			expect(response).to redirect_to(products_path)
		end
	end

	describe 'GET #logs' do
		it 'should show a list of product_logs' do
			product_logs = product.product_logs

			get :logs, params: {id: product.id}
			expect(assigns(:product_logs)).to match_array(product_logs)
		end
	end

	describe 'GET #show_log' do
		it 'should show a product log' do
			get :show_log, params: {id: product_log.id}
			expect(assigns(:product_log)).to eq(product_log)
		end
	end

	describe 'GET #export_csv' do
    let(:file_options) {{filename: "products-#{Date.today}.csv", type: 'text/csv; charset=shift_jis'}}

    before do
    	create_list(:product, 3)
      expect(@controller).to receive(:send_data)
         .with(Product.to_csv.encode(Encoding::SJIS), file_options) {allow(@controller).to receive(:render).and_return(:nothing)}
    end

    it 'it should export csv file' do
      get :export_csv, format: :csv
    end
  end

	describe 'GET #export_csv' do
    let(:file_options) {{filename: "products-#{Date.today}.csv", type: 'text/csv; charset=shift_jis'}}

    before do
    	create_list(:product, 3)
      expect(@controller).to receive(:send_data)
         .with(Product.to_csv.encode(Encoding::SJIS), file_options) {allow(@controller).to receive(:render).and_return(:nothing)}
    end

    it 'it should export csv file' do
      get :export_csv, format: :csv
    end
  end

	describe 'GET #export_report' do
    let(:file_options) {{filename: "product-report-#{Date.today}.csv", type: 'text/csv; charset=shift_jis'}}

    before do
			create(:product_report, :site_id => site.id, :product_id => product.id)
			create(:product_report, :site_id => site.id, :product_id => product.id)
    	create(:product_report, :site_id => site.id, :product_id => product.id)
      expect(@controller).to receive(:send_data)
         .with(ProductReport.day_reports.to_csv.encode(Encoding::SJIS), file_options) {allow(@controller).to receive(:render).and_return(:nothing)}
    end

    it 'it should export csv file' do
      get :export_report, format: :csv
    end
  end

end
