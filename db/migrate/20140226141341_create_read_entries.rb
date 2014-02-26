class CreateReadEntries < ActiveRecord::Migration
  def change
    create_table :read_entries do |t|
      t.string :user_id
      t.string :entry_id

      t.timestamps
    end
  end
end
