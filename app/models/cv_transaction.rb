class CvTransaction < ApplicationRecord
  include ScopingConcern

  before_create :generate_cv_transaction_key
  belongs_to :product, optional: true
  belongs_to :site, optional: true

  private

  def generate_cv_transaction_key
    begin
      self.cv_transaction_key = SecureRandom.hex
    end while self.class.exists?(cv_transaction_key: cv_transaction_key)
  end
end
