json.data do
  json.array!(@articles) do |article|
    json.extract! article, :id, :title, :summary, :url, :created_at, :updated_at, :external_id, :image_url, :image, :body, :published_date 
  end  
end
json.total_pages @articles.total_pages
json.current @page
