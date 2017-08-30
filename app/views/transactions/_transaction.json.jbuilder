json.extract! transaction, :id, :amount, :description, :event_date, :category_id, :user, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
