module V1::MessagesHelper
  def generate_url_with_option(session_statistic_id, product_id, product_url)
    return product_url unless product_url.downcase.include?("link-a")
    
    cv_transaction = CvTransaction.new(session_statistic_id: session_statistic_id, product_id: product_id)
    cv_transaction.save
    product_url.include?("?") ? product_url + "&option=" + cv_transaction.cv_transaction_key : product_url + "?option=" + cv_transaction.cv_transaction_key
  end

  def add_params_to_url(url, params = {})
    url += url.include?("?") ? ("&" + params.to_query) : ("?" + params.to_query)
  end

end
