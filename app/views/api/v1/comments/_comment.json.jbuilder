json.extract! comment,
              :id,
              :content,
              # :user,
              :parent_id,
              :created_at,
              :updated_at,
              :replying_to

json.user { json.extract! comment.user, :id, :username, :name, :photo }

json.replies do
  json.array! comment.replies do |reply|
    json.id reply['id']
    json.extract! reply,
                  :id,
                  :content,
                  :parent_id,
                  :created_at,
                  :updated_at,
                  :replying_to,
                  :user
  end
end
