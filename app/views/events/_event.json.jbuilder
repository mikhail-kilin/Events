json.extract! event, :id, :title, :content, :time_of_event, :period, :created_at, :updated_at
json.url event_url(event, format: :json)
