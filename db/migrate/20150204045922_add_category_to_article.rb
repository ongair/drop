class AddCategoryToArticle < ActiveRecord::Migration
  def change
    add_reference :articles, :category, index: true
    add_column :articles, :external_id, :string
    add_column :articles, :image_url, :string

  end
end
