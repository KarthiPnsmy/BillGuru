class CreateTokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.integer :user_id
      t.string :activation_tokn
      t.boolean :user_active,:default => false
      t.string :phone_tokn
      t.string :phone_no
      t.boolean :phone_active,:default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tokens
  end
end
