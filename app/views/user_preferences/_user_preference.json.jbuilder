json.extract! user_preference, :id, :nickname, :age, :user_id, :created_at, :updated_at
json.url user_preference_url(user_preference, format: :json)
