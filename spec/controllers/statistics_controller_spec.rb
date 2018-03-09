require 'rails_helper'

describe StatisticsController do
  let(:admin) {create(:user, :admin)}

  before(:each) do
    sign_in admin
  end

  describe 'GET #products' do
    it 'should show a list of products' do
      products = create_list(:product, 3)

      get :products
      expect(assigns(:products)).to match_array(products)
    end
  end

  describe 'GET #sessions' do
    it 'should show a list of sessions' do
      create_list(:session_statistic, 3)
      sessions = SessionStatistic.all.order(updated_at: :desc)

      get :sessions
      expect(assigns(:sessions)).to match_array(sessions)
    end
  end
end
