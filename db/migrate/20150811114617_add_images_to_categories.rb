class AddImagesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :image_uid,  :string
    add_column :categories, :image_name, :string
  end
end
