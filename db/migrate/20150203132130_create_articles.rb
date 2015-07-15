class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :source
      t.string :title
      t.text :summary
      t.string :url
      t.string :article_type
      t.text :metadata

      t.timestamps
    end
  end
end
