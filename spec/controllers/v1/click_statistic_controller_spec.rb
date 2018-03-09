require 'rails_helper'

describe V1::ClickStatisticController do
  # before(:each) do
  #   allow(@controller).to receive(:restrict_access).and_return(true)
  #   @category = create(:category)
  #   @product = create(:product)
  #   @session_statistic = create(:session_statistic)
  # end
  #
  # describe 'POST #create' do
  #   it 'in case category of success' do
  #     click = { type: 'Category', id: @category.id }
  #     expect {
  #       post :create, params: click, as: :json
  #     }.to change(ClickStatistic, :count).by(1)
  #     expect(JSON.parse(response.body)['status']).to eq 'ok'
  #   end
  #
  #   it 'in case product of success' do
  #     click = { type: 'Product', id: @product.id }
  #     expect{
  #       post :create, params: click, as: :json
  #     }.to change(ClickStatistic, :count).by(1)
  #     expect(JSON.parse(response.body)['status']).to eq 'ok'
  #   end
  #
  #   context 'in case fail, missing params[:type]' do
  #     it 'of category' do
  #       click = { type: '', id: @category.id }
  #       expect {
  #         post :create, params: click, as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect {
  #         post :create, params: click.except(:type), as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect {
  #         post :create, params: click.merge(type: 'test'), as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect(JSON.parse(response.body)['status']).to eq ''
  #     end
  #
  #     it 'of product' do
  #       click = { type: '', id: @product.id }
  #       expect {
  #         post :create, params: click, as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect {
  #         post :create, params: click.except(:type), as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect {
  #         post :create, params: click.merge(type: 'test'), as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect(JSON.parse(response.body)['status']).to eq ''
  #     end
  #   end
  #
  #   context 'in case fail, missing params[:id]' do
  #     it 'of category' do
  #       click = { type: 'Category', id: '' }
  #
  #       expect {
  #         post :create, params: click, as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect {
  #         post :create, params: click.except(:id), as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect {
  #         post :create, params: click.merge(id: 99999), as: :json
  #       }.to change(ClickStatistic, :count).by(0)
  #
  #       expect(JSON.parse(response.body)['status']).to eq ''
  #     end
  #   end
  #
  #   it 'in case fail with clicked' do
  #     click = { type: 'Product', id: @product.id }
  #     post :create, params: click, as: :json
  #
  #     expect {
  #       post :create, params: click, as: :json
  #     }.to change(ClickStatistic, :count).by(0)
  #     expect(JSON.parse(response.body)['status']).to eq ''
  #   end
  #
  #   # it 'in case fail can not save' do
  #   # end
  # end

end
