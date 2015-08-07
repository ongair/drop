json.data do
  json.array!(@articles) do |article|
    json.extract! article, :id, :title, :summary, :url, :created_at, :updated_at, :external_id
  end
end