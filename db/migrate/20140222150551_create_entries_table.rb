class CreateEntriesTable < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url
      t.string :author
      t.string :image
      t.text :summary
      t.text :content
      t.datetime :published_on
      t.integer :feed_id

      t.timestamps
    end
  end

  say "Created a table for entries"

end
