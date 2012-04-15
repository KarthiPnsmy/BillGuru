class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
  def index
    if params[:search_user]
        @users = User.paginate :per_page => 10, :page => params[:page],:conditions => ["name like ?","#{params[:search_user]}%"], :order => 'name ASC'
	if @users.blank?
	      flash.now[:error] = "User not Found."
	end
    else
	@users = User.paginate(:page => params[:page],:per_page => 10)
    end
    @title = "All users"
  end

  def search

  end

  def show
    @user = User.find(params[:id])
    #@microposts = @user.microposts.paginate(:page => params[:page],:per_page => 5)
    @title = @user.name
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @user  = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    #@user.confirmation_token = generate_activation_code(20)
    if @user.save
      #sign_in @user
      #Token.new({:activation_tokn => generate_activation_code(20),:user_id => @user.id})
      @token = Token.new
      @token.activation_tokn = generate_activation_code(20)
      @token.user_id = @user.id
      @token.save
      Notification.deliver_activate_user(@user) 
      redirect_to root_path, :flash => { :success => "Registration completed successfully. Activation link sent to your email id" }
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      redirect_to root_path, :flash => { :success => "Profile updated. Please login again to continue" }
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :flash => { :success => "User destroyed." }
  end

  def activate
    puts "activate account ---------> "
    puts params[:token]
    token = Token.find(:first, :conditions => {:activation_tokn => params[:token]})
    if (!params[:token].blank?) && token && !token.user_active?
       #user.confirmed!
       #self.current_user = user
	token.update_attributes(:user_active => true, :activation_tokn => '')
       sign_in token.user
       redirect_to root_path, :flash => { :success => "Thank you. You account is now activated." }
   else
      redirect_to root_path, :flash => { :error => "Sorry something went wrong." }
   end
  end
	
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end
