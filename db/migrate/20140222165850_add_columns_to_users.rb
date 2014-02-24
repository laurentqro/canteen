class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bio, :text
    add_column :users, :avatar, :string
    add_column :users, :role, :string
  end

  say "Add name, bio, avatar and role to users"

end
