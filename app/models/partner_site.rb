class PartnerSite < ApplicationRecord
  include ScopingConcern

  belongs_to :site, optional: true
end
