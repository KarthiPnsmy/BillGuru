class AddConfirmationTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed, :boolean, :default => false
  end

  def self.down
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed
  end
end
