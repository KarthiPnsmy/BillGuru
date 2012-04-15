namespace :alert  do
  desc "create some reminder notification"
  task :send_reminder => :environment do
    logger.info "create some reminder notification"
    logger.info "This task running at ======== #{Time.now} ======="
    @users = User.all
    for user in @users
    logger.info "#{user.name} email is #{user.email}"
         user.reminders.each { |reminder|
                logger.info "--user--#{user.name} ,reminder #{reminder.description} ,origin due #{reminder.due_date} ,threshold #{reminder.alert_threshold} "
                @new_due = reminder.due_date-reminder.alert_threshold.to_i.days
                logger.info "new due #{@new_due}"
                if @new_due == Date.today
                    logger.info "send reminder"
                    Notification.deliver_email_bill_reminder(user, reminder) unless user.email.blank?
                else
                    logger.info "dont send reminder"
                end
                    reminder.payments.each { |payment|

                    }
         }
    end
  end

  task :create_payment => :environment do
    puts "create automatic payment for unpaid bills"
    @users = User.all
    for user in @users
          p "#{user.name} email is #{user.email}"
         user.reminders.each { |reminder|
              	p "--user--#{user.name} ,reminder #{reminder.description} ,origin due #{reminder.due_date} ,threshold #{reminder.alert_threshold} "
                @new_due = reminder.due_date
                p "new due #{@new_due}"
                if @new_due == Date.today
                  p "creating auto payment"
                    Payment.create!(:reminder_id =>reminder.id,:pay_date => Date.today,:amount  => 0, :notes => '')
                    p "ponstpond the due date"

                    @reminder = Reminder.find_by_id(reminder.id)
                    p @reminder.alert_type
                    p @reminder

                    if @reminder.alert_type == "1"
                    p "weekly ----"
                    @reminder.due_date = @reminder.due_date+7.days
                      elsif @reminder.alert_type == "2"
                    p "monthly ----"
                    @reminder.due_date = @reminder.due_date+1.month
                      elsif @reminder.alert_type == "3"
                    p "two months ----"
                    @reminder.due_date = @reminder.due_date+2.month
                      elsif @reminder.alert_type == "0"
                    p "one day ----"
                    @reminder.due_date = @reminder.due_date+1.day
                    end
                    @reminder.save
                else
                  p "due out of limit"
                end
                
                reminder.payments.each { |payment|

                }
         }
    end
  end
end



