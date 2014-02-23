class CreateBookmarksTable < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :entry_id
      t.integer :user_id

      t.timestamps
    end
  end
end
