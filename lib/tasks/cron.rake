desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if Time.now.hour % 4 == 0 # run every four hours
    puts "Updating feed..."
    puts "feed sending at ======== #{Time.now} ======="
    puts "done."
  end

  if Time.now.hour % 2 == 0 # run every two hours
    puts "create some mail notification"
    puts "This mail sending at ======== #{Time.now} ======="
    Notification.deliver_test_mail()
    puts "mail was sent successfully!"
  end

  if Time.now.hour == 0 # run at midnight
    puts "create midnight notification"
    puts "This mid notification sending at ======== #{Time.now} ======="
  end
end
