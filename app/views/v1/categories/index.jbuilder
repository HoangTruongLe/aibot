json.array! @categories.each do |cate|
  json.id cate.id
  json.name cate.name
  json.slug cate.slug
  json.tags cate.tags
  json.eval_A_name cate.eval_A_name
  json.eval_A_type cate.eval_A_type
  json.eval_A_value cate.eval_A_value
  json.eval_B_name cate.eval_B_name
  json.eval_B_type cate.eval_B_type
  json.eval_B_value cate.eval_B_value
  json.eval_C_name cate.eval_C_name
  json.eval_C_type cate.eval_C_type
  json.eval_C_value cate.eval_C_value
  json.eval_D_name cate.eval_D_name
  json.eval_D_type cate.eval_D_type
  json.eval_D_value cate.eval_D_value
  json.eval_E_name cate.eval_E_name
  json.eval_E_type cate.eval_E_type
  json.eval_E_value cate.eval_E_value
  json.activity cate.activity
end
