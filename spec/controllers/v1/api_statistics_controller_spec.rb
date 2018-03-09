require 'rails_helper'

describe V1::ApiStatisticsController do
  before(:each) do
    allow(@controller).to receive(:restrict_access).and_return(true)
  end

  describe 'POST a product click' do
    context 'with valid attributes' do
      it 'count a product one click' do
        post :click_statistic, params: attributes_for(:product_statistic).except(:statistic_type), format: 'application/json'
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST a product display' do
    context 'with valid attributes' do
      it 'count a product one display' do
        params = {
                    statistics:
                      [
                        { site_id: "1", product_id: "1", display_url: "http://chicoli.net" },
                        { site_id: "1", product_id: "3", display_url: "http://chicoli.net" },
                        { site_id: "1", product_id: "2", display_url: "http://chicoli.net" },
                        { site_id: "1", product_id: "4", display_url: "http://chicoli.net" }
                      ]
                  }
        post :display_statistic, params: params, format: 'application/json'
        expect(response.status).to eq 204
      end
    end
  end
end
