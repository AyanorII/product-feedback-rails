json.partial! 'api/v1/products/product', product: @product
json.comments do
  json.array! @comments do |comment|
    json.partial! 'api/v1/comments/comment',
                  comment: comment,
                  user: comment.user
  end
end
