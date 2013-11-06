json.array!(@adventures) do |adventure|
  json.extract! adventure, :summary, :details
  json.url adventure_url(adventure, format: :json)
end
