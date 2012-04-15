require 'rubygems'
require 'google_chart'

class PaymentsController < ApplicationController
before_filter :authenticate

  # GET /payments
  # GET /payments.xml
  def index
    @payments = Payment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.xml
  def show
    @payment = Payment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.xml
  def new
    @payment = Payment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.xml
  def create
    @payment = Payment.new(params[:payment])
    @payment.user_id = current_user.id
p "testing here 11111 ----"
p params[:payment][:reminder_id]


	    @reminder = Reminder.find_by_id(params[:payment][:reminder_id])
#p @reminder.alert_type
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
    respond_to do |format|
      if @payment.save

        format.html { redirect_to(@payment.reminder, :notice => 'Payment was successfully created.') }
        format.xml  { render :xml => @payment, :status => :created, :location => @payment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.xml
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to(@payment, :notice => 'Payment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.xml
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to :back}
      format.xml  { head :ok }
    end
  end

  def summary
    @title = "Payment Summary"
    @reminders = current_user.reminders
  end

  def report
    @title = "Payment Report"
    @reminders = current_user.reminders
    p "payment Report ------"
    p @reminders
      if params[:start]
        p @start_date = Date.civil(params[:start][:"start_date(1i)"].to_i,params[:start][:"start_date(2i)"].to_i,params[:start][:"start_date(3i)"].to_i)
        p @end_date = Date.civil(params[:end][:"start_date(1i)"].to_i,params[:end][:"start_date(2i)"].to_i,params[:end][:"start_date(3i)"].to_i)


#ids = LevelsQuestion.all(:select => "question_id", :conditions => "level_id = 15").collect(&:question_id)
#Question.all(:select => "id, name", :conditions => ["id not in (?)", ids])
p "the ids val is ------------"
ids = Reminder.all(:select => "id", :conditions => "user_id = #{current_user.id}").collect(&:id)
p ids
        #report generation
          @payments = Payment.paginate :per_page => 100,
                                       :page => params[:pay_page],
                                       :conditions => ["user_id = ? and pay_date between ? and ? ", current_user.id, "#{@start_date}%", "#{@end_date}%"], :order => 'pay_date DESC'
                                       #:conditions => ["title like ? and date between ? and ?","%#{@query_news}%", "#{@start_date}%", "#{@end_date}%"], :order => 'title ASC'
          if @payments.empty?
           flash.now[:notice] = 'No payments found in the given date range.'
          else
            p "pay length "
            p @payments.length
          end
      end
    end

  def analysis
    GoogleChart::PieChart.new('600x300', "Pie Chart",false) do |pc|

       current_user.reminders.each { |reminder|
              @total = 0
              reminder.payments.each { |payment|
                 @total+= payment.amount
              }
              p "#{reminder.description} , #{@total}"
              pc.data reminder.description.to_s , @total.to_i
              
       }
      #pc.data "Apples", 40
      #pc.data "Banana", 20
      #pc.data "Peach", 30
      #pc.data "Orange", 60
      pc.is_3d = true
      puts "\nPie Chart"
      puts pc.to_url
      # Pie Chart with no labels
      pc.show_labels = true
      puts "\nPie Chart (with no labels)"
      puts pc.to_url
      p @chart_url =  pc.to_url
    end
  end
  
end
