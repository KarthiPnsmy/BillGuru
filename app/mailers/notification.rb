class Notification < ActionMailer::Base
  default :from => "support@billguru.com"
 

  
	def activate_user(user)
		# email header information must be added here
		@recipients = user.email #Email address of the user
		@from = "support@billguru.com"
		@subject = "Activate your BillGuru Account "

		# email body substitutions go here

		@body["username"] = user.name
		#@body["password"] = activation_link
		@body["activation_url"] = $hostname+"/activate_account/#{user.token.activation_tokn}"
		@sent_on = Time.now
	end 

	def email_bill_reminder(user, reminder)
		# email header information must be added here
		@recipients = user.email #Email address of the user
		@from = "support@billguru.com"
		@subject = "BillGuru : Bill payment "+reminder.description+" due on "+reminder.due_date.to_s(:long)

		# email body substitutions go here

		@body["username"] = user.name
		@body["bill_description"] = reminder.description
		@body["bill_due"] = reminder.due_date.to_s(:long)
		@body["bill_edit_url"] = $hostname +"/reminders/#{reminder.id}/edit"
		@body["bill_pay_url"] = $hostname+"/payments/new?bill_id=#{reminder.id}"
		content_type "text/html"

		@sent_on = Time.now
	end


	def acknowledg_reminder(user, reminder)
		# email header information must be added here
		@recipients = user.email #Email address of the user
		@from = "support@billguru.com"
		@subject = "BillGuru : New Reminder "+reminder.description+" due on "+reminder.due_date.to_s(:long)

		# email body substitutions go here
		@body["username"] = user.name
		@body["bill_description"] = reminder.description
		@body["bill_due"] = reminder.due_date.to_s(:long)
		@body["bill_edit_url"] = $hostname+"/reminders/#{reminder.id}/edit"
		content_type "text/html"

		@sent_on = Time.now
	end

        def test_mail()
		# email header information must be added here
		@recipients = "karthi.nkl@gmail.com" #Email address of the user
		@from = "support@billguru.com"
		@subject = "BillGuru : test mail"

		# email body substitutions go here
		@body["username"] = "karthik"
		
		content_type "text/html"

		@sent_on = Time.now
	end

end
