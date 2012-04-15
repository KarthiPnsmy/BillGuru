class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.integer :user_id
      t.text :description
      t.date :due_date
      t.integer :alert_threshold
      t.boolean :email
      t.boolean :sms
      t.boolean :facebook
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
