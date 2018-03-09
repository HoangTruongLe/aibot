class PartnerSitesController < ApplicationController
  def index
    add_breadcrumb t('partner_sites.index')
    @q = PartnerSite.ransack(params[:q])
    @partner_sites = @q.result.page(params[:page]).order(:id)
  end
end
