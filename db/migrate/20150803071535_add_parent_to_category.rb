class AddParentToCategory < ActiveRecord::Migration
  def change
    # add_reference :categories, :parent, index: true
    # add_foreign_key :categories, :parents
  end
end
