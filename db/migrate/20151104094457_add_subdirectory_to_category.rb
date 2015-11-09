class AddSubdirectoryToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :subdirectory, :string
  end
end
