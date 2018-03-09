json.array! @products.each do |product|
  json.id product.id
  json.site_id product.try(:site).try(:id)
  json.name product.name
  json.slug product.slug
  json.category_name product.category.name
  json.tags product.tags
  json.category product.category.name
  json.description product.description
  json.product_url product.product_url || ''
  json.image_1_url product.image_1_url ? product.image_1_url.split(",") : []
  json.image_2_url product.image_2_url ? product.image_2_url.split(",") : []
  json.image_3_url product.image_3_url ? product.image_3_url.split(",") : []
  json.image_4_url product.image_4_url ? product.image_4_url.split(",") : []
  json.image_5_url product.image_5_url ? product.image_5_url.split(",") : []
end
