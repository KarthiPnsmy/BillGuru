require 'spec_helper'

describe "reminders/new.html.erb" do
  before(:each) do
    assign(:reminder, stub_model(Reminder,
      :user_id => 1,
      :description => "MyText",
      :type => "MyString",
      :alert_threshold => 1,
      :email => false,
      :sms => false,
      :facebook => false,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new reminder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reminders_path, :method => "post" do
      assert_select "input#reminder_user_id", :name => "reminder[user_id]"
      assert_select "textarea#reminder_description", :name => "reminder[description]"
      assert_select "input#reminder_type", :name => "reminder[type]"
      assert_select "input#reminder_alert_threshold", :name => "reminder[alert_threshold]"
      assert_select "input#reminder_email", :name => "reminder[email]"
      assert_select "input#reminder_sms", :name => "reminder[sms]"
      assert_select "input#reminder_facebook", :name => "reminder[facebook]"
      assert_select "textarea#reminder_notes", :name => "reminder[notes]"
    end
  end
end
