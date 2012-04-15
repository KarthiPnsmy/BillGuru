class AddAlertTypeToReminders < ActiveRecord::Migration
  def self.up
    add_column :reminders, :alert_type, :string
  end

  def self.down
    remove_column :reminders, :alert_type
  end
end
