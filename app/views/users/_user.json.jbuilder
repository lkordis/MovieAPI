json.extract! user, :id, :created_at, :updated_at, :name, :email
json.url user_url(user, format: :json)
