json.array!(@events) do |event|
  json.extract! event, :name, :text, :public
  json.url event_url(event, format: :json)
end
