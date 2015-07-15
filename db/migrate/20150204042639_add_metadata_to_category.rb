class AddMetadataToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :metadata, :text
    add_column :categories, :description, :text
  end
end
