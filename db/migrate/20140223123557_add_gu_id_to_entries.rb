class AddGuIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :gu_id, :string
  end

  say "Add GUID to entries"

end
