json.data do
  json.array!(@articles) do |article|
    json.extract! article, :id, :title, :summary, :url, :created_at, :updated_at, :external_id, :image_url, :image 
    json.category article.category, :id, :name
  end  
end
json.total_pages @total_pages
json.current @page
