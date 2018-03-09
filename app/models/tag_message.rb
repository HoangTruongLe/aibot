class TagMessage < ApplicationRecord
  belongs_to :message, optional: true
  belongs_to :tag
end
