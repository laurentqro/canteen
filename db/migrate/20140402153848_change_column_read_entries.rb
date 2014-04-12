class ChangeColumnReadEntries < ActiveRecord::Migration
  def up
    change_column :read_entries, :user_id, :integer
  end

  def down
    change_column :read_entries, :user_id, :string
  end
end
