class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
