class AddTrackableFieldsToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :sign_in_count, :integer
    add_column :subscribers, :current_sign_in_at, :datetime
    add_column :subscribers, :last_sign_in_at, :datetime
    add_column :subscribers, :current_sign_in_ip, :string
    add_column :subscribers, :last_sign_in_ip, :string
    remove_column :subscribers, :source
    remove_column :subscribers, :external_id
  end
end
