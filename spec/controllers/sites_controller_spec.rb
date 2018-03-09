require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  let(:admin) {create(:user, :admin)}
  let(:site) {create(:site)}

  before(:each) do
    sign_in admin
  end

  describe 'GET #index' do
    it 'should show a list of sites' do
      sites = create_list(:site, 3)

      get :index
      expect(assigns(:sites)).to match_array(sites)
    end
  end

  describe 'GET #show' do
    it 'should show a specific site' do
      get :show, params: {id: site.id}
      expect(assigns(:site)).to eq(site)
    end
  end

  describe 'GET #new' do
    it 'create a new site' do
      get :new
      expect(assigns(:site)).to be_a_new(Site)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new site' do
        expect{
          post :create, params: {site: attributes_for(:site)}
        }.to change(Site, :count).by(1)

        expect(response).to redirect_to(sites_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new site' do
        expect{
          post :create, params: {site: attributes_for(:site, name: '')}
        }.to_not change(Site, :count)
      end

      it 'render to new action' do
        post :create, params: {site: attributes_for(:site, name: '')}
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    it 'should edit a specific site' do
      get :edit, params: {id: site.id}
      expect(assigns(:site)).to eq(site)
    end
  end

  describe 'PUT #update' do
    it 'in case of succeed' do
      put :update, params: {id: site.id, site: attributes_for(:site, name: 'updated_name')}
      site.reload

      expect(site.name).to eq 'updated_name'
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to(sites_path)
    end

    it 'in case of failure' do
      put :update, params: {id: site.id, site: attributes_for(:site, name: '')}
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'should destroy a site' do
      expect{ 
        delete :destroy, params: {id: site.id}
      }.to change(Site, :count).by(0)

      expect(flash[:notice]).to be_present
      expect(response).to redirect_to(sites_path)
    end
  end
end
