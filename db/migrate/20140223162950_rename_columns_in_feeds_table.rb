class RenameColumnsInFeedsTable < ActiveRecord::Migration
  change_table :feeds do |t|
    t.rename :gu_id, :etag
    t.rename :last_updated, :last_modified
  end
end
