class ProductLog < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true
  belongs_to :site

  def self.build_from_product(args = {})
    product_log = ProductLog.new

    product_log.name = args["name"]
    product_log.category_id = args["category_id"]
    product_log.product_url = args["product_url"]
    product_log.slug = args["slug"]
    product_log.catch_copy = args["catch_copy"]
    product_log.price_per_time = args["price_per_time"]
    product_log.price = args["price"]
    product_log.campaign = args["campaign"]
    product_log.order_site = args["order_site"]
    product_log.manufacturer = args["manufacturer"]
    product_log.specificity = args["specificity"]
    product_log.content = args["content"]
    product_log.price_details = args["price_details"]
    product_log.useful_ingredients = args["useful_ingredients"]
    product_log.components = args["components"]
    product_log.usage_target = args["usage_target"]
    product_log.image_1_url = args["image_1_url"]
    product_log.image_2_url = args["image_2_url"]
    product_log.image_3_url = args["image_3_url"]
    product_log.image_4_url = args["image_4_url"]
    product_log.image_5_url = args["image_5_url"]
    product_log.evaluation_score_a = args["evaluation_score_a"]
    product_log.evaluation_score_b = args["evaluation_score_b"]
    product_log.evaluation_score_c = args["evaluation_score_c"]
    product_log.evaluation_score_d = args["evaluation_score_d"]
    product_log.evaluation_score_e = args["evaluation_score_e"]
    product_log.evaluation_comment_a = args["evaluation_comment_a"]
    product_log.evaluation_comment_b = args["evaluation_comment_b"]
    product_log.evaluation_comment_c = args["evaluation_comment_c"]
    product_log.evaluation_comment_d = args["evaluation_comment_d"]
    product_log.evaluation_comment_e = args["evaluation_comment_e"]
    product_log.evaluation_category_a = args["evaluation_category_a"]
    product_log.evaluation_category_b = args["evaluation_category_b"]
    product_log.evaluation_category_c = args["evaluation_category_c"]
    product_log.evaluation_category_d = args["evaluation_category_d"]
    product_log.evaluation_category_e = args["evaluation_category_e"]
    product_log.summary = args["summary"]
    product_log.money_back = args["money_back"]
    product_log.status_deliver_time = args["status_deliver_time"]
    product_log.credit_settlement = args["credit_settlement"]
    product_log.postpay = args["postpay"]
    product_log.cod = args["cod"]
    product_log.bank_transfer = args["bank_transfer"]
    product_log.store_transfer = args["store_transfer"]
    product_log.delivery_date = args["delivery_date"]
    product_log.deleted_at = args["deleted_at"]
    product_log.csv_file_name = args["csv_file_name"]
    product_log.site_id = args["site_id"]

    product_log.user_id = args["user_id"]
    product_log.product_id = args["product_id"]

    product_log
  end

end
