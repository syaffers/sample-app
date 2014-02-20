json.array!(@papers) do |paper|
  json.extract! paper, :title, :url, :user_id
  json.url paper_url(paper, format: :json)
end