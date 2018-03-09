module KeywordCpcConcern
  def update_msg messages
    messages.each do |msg|
      mk_cpc = (msg.keyword && msg.keyword.cpc) ? msg.keyword.cpc : 0
      rk_cpc = []
      msg.relative_keywords.each do |rk|
        cpc = (rk.keyword && rk.keyword.cpc) ? rk.keyword.cpc : 0
        rk_cpc << cpc
      end
      weight = calculate_weight(mk_cpc, rk_cpc, msg.priority)
      msg.update(weight: weight)
    end
  end
  
  def calculate_weight mk_cpc, rk_cpc, priority
    mk_weight = Setting.find_by_meta_key(:main_key_weight).meta_value.to_f if Setting.find_by_meta_key(:main_key_weight)
    rk_weight = Setting.find_by_meta_key(:relative_key_weight).meta_value.to_f if Setting.find_by_meta_key(:relative_key_weight)
    rk_cpc = rk_cpc.reduce(:+).to_f / rk_cpc.size unless rk_cpc.blank?
    rk_cpc = 0 if rk_cpc.nil? || rk_cpc.blank?
    weight = (mk_weight * mk_cpc + rk_weight * rk_cpc) * priority
  end
end
