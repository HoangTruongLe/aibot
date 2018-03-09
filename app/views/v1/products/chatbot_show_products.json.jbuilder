json.data do
  if @close_message
    json.close_message do
      json.id @close_message.id
      json.content @close_message.content
    end
  end
  json.products do
    json.array! @products.each do |product|
      json.id product.id
      json.name product.name
      json.product_url product.product_url
      json.image_1_url product.image_1_url ? product.image_1_url.split(',').first : product.image_1_url
      json.image_2_url product.image_2_url ? product.image_2_url.split(',').first : product.image_2_url
    end
  end
end
