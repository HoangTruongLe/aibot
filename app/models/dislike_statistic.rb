class DislikeStatistic < ApplicationRecord
  include ScopingConcern
  
  belongs_to :dislike, polymorphic: true
  belongs_to :session_statistic, optional: true
  belongs_to :site, optional: true
end
