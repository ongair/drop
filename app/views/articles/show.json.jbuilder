json.extract! @article, :id, :title, :summary, :url, :created_at, :updated_at, :article_type, :image_url, :body 
json.category @article.category, :id, :name
