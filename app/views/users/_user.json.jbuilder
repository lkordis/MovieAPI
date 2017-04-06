json.extract! user, :id, :created_at, :updated_at, :name, :email, :lastName, :password_digest
json.url user_url(user, format: :json)
