json.data
  json.array!(@articles) do |article|
    json.extract! article, :id, :title, :summary, :url, :created_at, :updated_at, :article_type, :image_url
  end
end
