class AddGuIdToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :gu_id, :string
  end
end
