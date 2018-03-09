class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery prepend: true

  before_action :authenticate_user!
  around_action :scope_current_site
  helper_method :current_sites

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  add_breadcrumb "TOP", :root_path

  def add_updated_user(message_id)
    msg = Message.unscoped.find_by_id(message_id)
    msg.updated_user = current_user
    msg.save
  end

  def prevent_xhr_cache
    if request.xhr?
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end
  end

  def authenticate_admin
    redirect_to :root unless current_user && current_user.admin?
  end

  private

  def current_sites
    current_user && current_user.admin? ? Site.all : current_user.try(:sites)
  end

  def scope_current_site
    begin
      session[:site_id] = current_sites.try(:first).try(:id) if !session[:site_id] && current_sites
      User.current_site_id = session[:site_id]
      yield
    ensure
      User.current_site_id = nil
    end
  end

  def record_not_found
    redirect_to controller: (controller_path ? controller_path : root_path)
  end

end
