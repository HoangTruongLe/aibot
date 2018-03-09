class ClickStatistic < ApplicationRecord
  include ScopingConcern

  belongs_to :clicked, polymorphic: true
  belongs_to :session_statistic, optional: true
  belongs_to :site, optional: true
end
