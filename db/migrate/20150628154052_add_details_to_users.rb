class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :avatar, :string
    add_column :users, :banned, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
