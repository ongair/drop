class AddLogoToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :logo, :text
  end
end
