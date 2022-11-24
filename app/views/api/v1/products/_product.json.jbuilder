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
json.comment_count product.comments.length
