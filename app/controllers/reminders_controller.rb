require 'net/http'
require 'cgi'
class RemindersController < ApplicationController
before_filter :authenticate

  require 'net/http'
  # GET /reminders
  # GET /reminders.xml
  def index
    #@reminders = Reminder.all

     @reminders = current_user.reminders.paginate(:page => params[:page],:per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reminders }
    end
  end

  # GET /reminders/1
  # GET /reminders/1.xml
  def show
    @reminder = Reminder.find(params[:id])
    @payments =  @reminder.payments.paginate(:page => params[:page],:per_page => 10)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/new
  # GET /reminders/new.xml
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reminder }
    end
  end

  # GET /reminders/1/edit
  def edit
    @reminder = Reminder.find(params[:id])
  end

  # POST /reminders
  # POST /reminders.xml
  def create
    #@reminder = Reminder.new(params[:reminder])
p "the reminder params --------->"
p params[:reminder]
#p params[:reminder][:due_date(1i)]
     @reminder = current_user.reminders.build(params[:reminder])
    respond_to do |format|
      if @reminder.save
        #email notification
        Notification.deliver_acknowledg_reminder(current_user, @reminder) unless current_user.email.blank?
        #sms notification
        send_ack_sms(@reminder)
        format.html { redirect_to(reminders_path, :notice => 'Reminder was successfully created.') }
        format.xml  { render :xml => @reminder, :status => :created, :location => @reminder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.xml
  def update
    @reminder = Reminder.find(params[:id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder])
        format.html { redirect_to(reminders_path, :notice => 'Reminder was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.xml
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to(reminders_url) }
      format.xml  { head :ok }
    end
  end

  private

  def send_ack_sms(reminder)
    p "sending the sms ---------------->"
    p current_user.token.phone_active
    p current_user.token.phone_no
    p reminder.sms

    if current_user.token.phone_active and current_user.token.phone_no and reminder.sms
      @msg1 = "New reminder was created by you just now @BillGuru.com & Due Date is "+reminder.due_date.to_s(:long)+"- BillGuru Team"
      p @msg1
      @msg = CGI.escape(@msg1)
      p "current_user.token.phone_no --------"
      p current_user.token.phone_no
      p @msg
      sms_url = "http://ubaid.tk/sms/sms.aspx?uid=9788787445&pwd=2348&msg="+@msg+"&phone="+current_user.token.phone_no+"&provider=way2sms"
      p "sms url"
      p sms_url
      result = Net::HTTP.get(URI.parse(sms_url))
      p "result"
      p result
      if result == "1"
              #redirect_to :back, :flash => { :success => "Activation code sent to your Mobile No" }
      else
              #redirect_to :back, :flash => { :error => "Unable to send SMS" }
      end
    end
  end
end
