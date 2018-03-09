class V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :restrict_access
  skip_before_action :authenticate_user!

  def session_interaction
    # update session interaction
    if session_key = get_session_key
      @session_statistic = SessionStatistic.find_by_session_key(session_key) ||
                            SessionStatistic.new(session_key: session_key, location: @location, ip_address: @ip_address, browser: @browser, platform: @platform)
      @session_statistic.save
    else
      return
    end
  end

  protected

  def get_session_key
    @location = request.headers["X-Location"]
    @ip_address = request.headers["X-Ip-Address"]
    @browser = request.headers["X-Browser"]
    @platform = request.headers["X-Platform"]
    request.headers["X-session-key"]
  end

  def restrict_access
    # Restrict header with: Authorization: Token token="access_token"
    authenticate_or_request_with_http_token do |token, options|
      @site = ApiKey.find_by_access_token(token).try(:site) || nil
      User.current_site_id = @site.id
      ApiKey.exists?(access_token: token)
    end
  end
end
