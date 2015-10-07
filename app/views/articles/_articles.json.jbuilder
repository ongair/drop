json.data do
  json.array!(@combined) do |article|
    json.extract! article, :id, :title, :summary, :url, :created_at, :updated_at, :external_id, :image_url, :image, :body, :published_date, :shortened_url 
    json.category article.category, :id, :name
  end  
end
json.total_pages @articles.total_pages
json.current @page
