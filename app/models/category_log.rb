class CategoryLog < ApplicationRecord
  include ScopingConcern

  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :site, optional: true

  def self.build_from_caterogy(args = {})
    category_log = CategoryLog.new
    category_log.name = args["name"]
    category_log.slug = args["slug"]
    category_log.eval_A_name = args["eval_A_name"]
    category_log.eval_A_type = args["eval_A_type"]
    category_log.eval_A_value = args["eval_A_value"]
    category_log.eval_B_name = args["eval_B_name"]
    category_log.eval_B_type = args["eval_B_type"]
    category_log.eval_B_value = args["eval_B_value"]
    category_log.eval_C_name = args["eval_C_name"]
    category_log.eval_C_type = args["eval_C_type"]
    category_log.eval_C_value = args["eval_C_value"]
    category_log.eval_D_name = args["eval_D_name"]
    category_log.eval_D_type = args["eval_D_type"]
    category_log.eval_D_value = args["eval_D_value"]
    category_log.eval_E_name = args["eval_E_name"]
    category_log.eval_E_type = args["eval_E_type"]
    category_log.eval_E_value = args["eval_E_value"]
    category_log.deleted_at = args["deleted_at"]
    category_log.user_id = args["user_id"]
    category_log.category_id = args["id"]
    category_log.activity = args["activity"]
    category_log.tags = args["tags"]
    category_log
  end
end
