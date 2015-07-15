class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :source
      t.string :external_id
      t.string :name
      t.timestamps
    end
  end
end
