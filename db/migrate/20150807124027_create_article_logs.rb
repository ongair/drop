class CreateArticleLogs < ActiveRecord::Migration
  def change
    create_table :article_logs do |t|
      t.references :article, index: true
      t.references :subscriber, index: true
      t.string :type

      t.timestamps null: false
    end
    add_foreign_key :article_logs, :articles
    add_foreign_key :article_logs, :subscribers
  end
end
