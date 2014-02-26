class AddPrivateToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :private, :boolean
  end
end
