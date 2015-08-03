class AddColumnsToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :provider, :string
    add_column :subscribers, :uid, :string
  end
end
