class AddJuicerIdToSource < ActiveRecord::Migration
  def change
    add_column :sources, :juicer_id, :string
  end
end
