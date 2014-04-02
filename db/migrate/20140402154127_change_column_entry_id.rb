class ChangeColumnEntryId < ActiveRecord::Migration
  def up
    change_column :read_entries, :entry_id, :integer
  end

  def down
    change_column :read_entries, :entry_id, :string
  end
end
