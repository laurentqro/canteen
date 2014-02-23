class AddGuIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :gu_id, :string
  end
end
