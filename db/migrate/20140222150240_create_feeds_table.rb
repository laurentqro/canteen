class CreateFeedsTable < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.string :publisher_url
      t.datetime :last_updated

      t.timestamps
    end
  end
end
