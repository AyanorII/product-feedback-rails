json.array! @products do |product|
  json.extract! product,
                :id,
                :title,
                :description,
                :category,
                :upvotes,
                :created_at,
                :updated_at,
                :user_id
  json.status product.status.dasherize
  json.comments_count product.comments.count
end
