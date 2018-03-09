json.data do
  if @close_message
    json.message do
      json.content @close_message.content
      json.id @close_message.id
    end
  end
  if @product
    json.product do
      json.id @product.id
      json.name @product.name
      json.category_name @product.category.name
      json.product_url @product.product_url
      json.slug @product.slug
      json.catch_copy @product.catch_copy
      json.price_per_time number_to_currency(@product.price_per_time, :unit => "¥")
      json.price number_to_currency(@product.price, :unit => "¥")
      json.campaign @product.campaign
      json.order_site @product.order_site
      json.manufacturer @product.manufacturer
      json.specificity @product.specificity
      json.content @product.content
      json.price_details @product.price_details
      json.useful_ingredients @product.useful_ingredients
      json.components @product.components
      json.usage_target @product.usage_target
      json.image_1_url @product.image_1_url ? @product.image_1_url.split(",") : []
      json.image_2_url @product.image_2_url ? @product.image_2_url.split(",") : []
      json.image_3_url @product.image_3_url ? @product.image_3_url.split(",") : []
      json.image_4_url @product.image_4_url ? @product.image_4_url.split(",") : []
      json.image_5_url @product.image_5_url ? @product.image_5_url.split(",") : []
      json.description @product.description
      json.evaluation_score_a @product.evaluation_score_a
      json.evaluation_score_b @product.evaluation_score_b
      json.evaluation_score_c @product.evaluation_score_c
      json.evaluation_score_d @product.evaluation_score_d
      json.evaluation_score_e @product.evaluation_score_e
      json.evaluation_comment_a @product.evaluation_comment_a
      json.evaluation_comment_b @product.evaluation_comment_b
      json.evaluation_comment_c @product.evaluation_comment_c
      json.evaluation_comment_d @product.evaluation_comment_d
      json.evaluation_comment_e @product.evaluation_comment_e
      json.evaluation_category_a @product.evaluation_category_a
      json.evaluation_category_b @product.evaluation_category_b
      json.evaluation_category_c @product.evaluation_category_c
      json.evaluation_category_d @product.evaluation_category_d
      json.evaluation_category_e @product.evaluation_category_e
    end
  end
end
