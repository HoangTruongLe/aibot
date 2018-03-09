require 'rails_helper'

RSpec.describe CvTransaction, type: :model do
  describe 'association' do
		it {should belong_to(:product)}
	end

  describe 'auto generate cv transaction key' do
    it 'before_create :generate_cv_transaction_key' do
      product = create(:product)
      product.cv_transactions.build.save
      expect(product.cv_transactions.count).to eq 1
      expect(product.cv_transactions.first.cv_transaction_key).to_not be_empty
    end
  end
end
