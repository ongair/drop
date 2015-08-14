class ChangeArticleLogType < ActiveRecord::Migration
  def change
    rename_column :article_logs, :type, :log_type
  end
end
