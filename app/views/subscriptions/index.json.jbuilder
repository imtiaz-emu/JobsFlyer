json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id
  json.url subscription_url(subscription, format: :json)
end
