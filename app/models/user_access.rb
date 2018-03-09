class UserAccess < ApplicationRecord
  include ScopingConcern
  
  belongs_to :site, optional: true
end
