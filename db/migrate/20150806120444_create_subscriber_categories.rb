class CreateSubscriberCategories < ActiveRecord::Migration
  def change
    create_table :subscriber_categories do |t|
      t.references :subscriber, index: true
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriber_categories, :subscribers
    add_foreign_key :subscriber_categories, :categories
  end
end
