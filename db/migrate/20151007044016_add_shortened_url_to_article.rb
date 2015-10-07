class AddShortenedUrlToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :shortened_url, :string
  end
end
