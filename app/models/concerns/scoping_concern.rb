module ScopingConcern
  extend ActiveSupport::Concern
  included do
    default_scope { where(site_id: User.current_site_id) }
    scope :activity, -> { where(activity: true) }
  end
end
