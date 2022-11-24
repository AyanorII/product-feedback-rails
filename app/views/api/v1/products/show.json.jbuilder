json.partial! 'api/v1/products/product', product: @product
json.comments do
  json.array! @product.comments do |comment|
    json.extract! comment, :id, :content, :parent_id, :created_at, :updated_at

    json.replies do
      json.array! comment.replies do |reply|
        json.id reply['id']
        json.extract! reply, :id, :content, :parent_id, :created_at, :updated_at
      end
    end
  end
end
