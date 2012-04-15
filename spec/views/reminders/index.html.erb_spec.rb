require 'spec_helper'

describe "reminders/index.html.erb" do
  before(:each) do
    assign(:reminders, [
      stub_model(Reminder,
        :user_id => 1,
        :description => "MyText",
        :type => "Type",
        :alert_threshold => 1,
        :email => false,
        :sms => false,
        :facebook => false,
        :notes => "MyText"
      ),
      stub_model(Reminder,
        :user_id => 1,
        :description => "MyText",
        :type => "Type",
        :alert_threshold => 1,
        :email => false,
        :sms => false,
        :facebook => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of reminders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
