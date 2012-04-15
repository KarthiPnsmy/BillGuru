require 'spec_helper'

describe "payments/new.html.erb" do
  before(:each) do
    assign(:payment, stub_model(Payment,
      :reminder_id => 1,
      :amount => 1,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payments_path, :method => "post" do
      assert_select "input#payment_reminder_id", :name => "payment[reminder_id]"
      assert_select "input#payment_amount", :name => "payment[amount]"
      assert_select "textarea#payment_notes", :name => "payment[notes]"
    end
  end
end
