require 'rails_helper'

describe V1::DislikeStatisticController do
	let(:product) {create(:product)}
	let(:category) {create(:category)}

	before(:each) do
		allow(@controller).to receive(:restrict_access).and_return(true)
	end

	describe 'POST #create' do
		context 'dislike_statistic_params type is product' do
			context 'with valid attributes' do
				it 'creates a new dislike_statistic' do
		      expect{
		        post :create, params: {id: product.id, type: 'Product', reason: 'a reason'}
		      }.to change(DislikeStatistic, :count).by(1)
		      expect(JSON.parse(response.body)["status"]).to eq 'ok'
		    end
			end
		end

		context 'dislike_statistic_params type is category' do
			context 'with valid attributes' do
				it 'creates a new dislike_statistic' do
		      expect{
						post :create, params: {id: category.id, type: 'Category', reason: 'a reason'}
		      }.to change(DislikeStatistic, :count).by(1)
		      expect(JSON.parse(response.body)["status"]).to eq 'ok'
		    end
			end
		end

    context 'in case fail, missing params[:type]' do
      it 'of category' do
        click = {id: category.id, type: 'Category', reason: 'a reason'}
        expect {
          post :create, params: click, as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect {
          post :create, params: click.except(:type), as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect {
          post :create, params: click.merge(type: 'test'), as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect(JSON.parse(response.body)['status']).to eq ''
      end

      it 'of product' do
        click = {id: product.id, type: 'Product', reason: 'a reason'}
        expect {
          post :create, params: click, as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect {
          post :create, params: click.except(:type), as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect {
          post :create, params: click.merge(type: 'test'), as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect(JSON.parse(response.body)['status']).to eq ''
      end
    end

    context 'in case fail, missing params[:id]' do
      it 'of category' do
        click = { type: 'Category', id: '' }

        expect {
          post :create, params: click, as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect {
          post :create, params: click.except(:id), as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect {
          post :create, params: click.merge(id: 99999), as: :json
        }.to change(ClickStatistic, :count).by(0)

        expect(JSON.parse(response.body)['status']).to eq ''
      end
    end

    it 'in case fail with clicked' do
      click = { type: 'Product', id: product.id }
      post :create, params: click, as: :json

      expect {
        post :create, params: click, as: :json
      }.to change(ClickStatistic, :count).by(0)
      expect(JSON.parse(response.body)['status']).to eq ''
    end

    # it 'in case fail can not save' do
    # end

	end
end
