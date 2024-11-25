json.extract! secret_santa, :id, :name, :code, :description, :created_at, :updated_at
json.url secret_santa_url(secret_santa, format: :json)
