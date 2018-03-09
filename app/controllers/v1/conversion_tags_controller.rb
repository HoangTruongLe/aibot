class V1::ConversionTagsController < V1::BaseController
  before_action :session_interaction

  def tracking_cv_tag
    return if ConversionTag.where(conversion_tag_params).last
    conversion_tag = nil
    
    if conversion_tag_params[:session_statistic_id]
      return unless SessionStatistic.find_by_id(conversion_tag_params[:session_statistic_id])
      conversion_tag = ConversionTag.new(conversion_tag_params)
    elsif conversion_tag_params[:referrer]
      cb_tag = ConversionTag.where(fingerprint: conversion_tag_params[:fingerprint], current_url: conversion_tag_params[:referrer]).last
      if cb_tag
        params[:session_statistic_id] = cb_tag.session_statistic_id
        conversion_tag = ConversionTag.new(conversion_tag_params)
      end
    end

    if conversion_tag && conversion_tag.save
      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
  end

  private

  def conversion_tag_params
    params.permit(:session_statistic_id, :fingerprint, :current_url, :referrer, :api_key)
  end
end