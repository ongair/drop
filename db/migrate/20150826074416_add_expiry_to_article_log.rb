class AddExpiryToArticleLog < ActiveRecord::Migration
  def change
    add_column :article_logs, :expired, :boolean, default: false
  end
end
