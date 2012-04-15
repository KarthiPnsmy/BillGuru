class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :reminder_id
      t.date :pay_date
      t.integer :amount, :limit => 8

      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
