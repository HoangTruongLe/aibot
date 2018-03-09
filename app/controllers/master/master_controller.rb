class Master::MasterController < ApplicationController
  before_action :set_master_breadcrumb

  private
  def set_master_breadcrumb
    add_breadcrumb t('master.master_breadcum')
  end
end
