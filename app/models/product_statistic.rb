class ProductStatistic < ApplicationRecord
  include ScopingConcern

  belongs_to :product
  belongs_to :site

  enum statistic_type: [:display, :click]
end
