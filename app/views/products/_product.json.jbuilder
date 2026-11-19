json.extract! product, :id, :title, :description, :image, :price, :enabled, :discount_price, :permalink, :created_at, :updated_at
json.url product_url(product, format: :json)
json.image url_for(product.image)
