class RelativeKeyword < ApplicationRecord
  belongs_to :keyword
  belongs_to :message, optional: true
end
