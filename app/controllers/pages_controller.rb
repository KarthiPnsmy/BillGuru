require 'net/http'
require 'cgi'
class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      #@micropost = Micropost.new
      #@feed_items = current_user.feed.paginate(:page => params[:page],:per_page => 10)
	@reminders = current_user.reminders.paginate(:page => params[:page],:per_page => 10)
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end

  def phone
    @title = "Phone"
    p "hi phone no xxx -------"
    p params[:pnone_no]
    if !params[:pnone_no].blank?
      ran_string = generate_activation_code(5)
      @msg = "This is the one time verifiction code from BillGuru.com. Verifiction code "+ran_string
      @msg = CGI.escape(@msg)

      @user = current_user.token
      @user.phone_no = params[:pnone_no]
      @user.phone_active = false
      @user.phone_tokn = ran_string
      @user.save

      #sms_url = "http://ubaid.tk/sms/sms.aspx?uid=9788787445&pwd=2348&msg="+ran_string+"&phone="+params[:pnone_no]+"&provider=way2sms"
      sms_url = "http://ubaid.tk/sms/sms.aspx?uid=9788787445&pwd=2348&msg="+@msg+"&phone="+params[:pnone_no]+"&provider=way2sms"
      p "sms url"
      p sms_url
      result = Net::HTTP.get(URI.parse(sms_url))
      p result
      if result == "1"
              redirect_to :back, :flash => { :success => "Activation code sent to your Mobile No" }
      else
        redirect_to :back, :flash => { :error => "Unable to send SMS" }
      end
    else
       redirect_to :back, :flash => { :error => "Please enter valid mobile no" }
    end
  end

  def verify_phone
    @title = "Verify Phone"
    p "Verify no -------"
    p params[:verify_no]
    if !params[:verify_no].blank?
	sent_token = current_user.token
        if params[:verify_no] == sent_token.phone_tokn and sent_token.user_id == current_user.id
                #token = Token.find(:first, :conditions => {:phone_tokn => params[:token]})
		sent_token.update_attributes(:phone_active => true, :phone_tokn => '')
          	redirect_to :back, :flash => { :success => "Phone no activated" }
        else
		redirect_to :back, :flash => { :error => "Verification code does not match" }
        end
    end
  end
end
