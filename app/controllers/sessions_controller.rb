class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      @active_user = user.token.user_active
	if !@active_user
	      flash.now[:error] = "Please activate your account."
	      @title = "Sign in"
	      render 'new'
	else
	      sign_in user
              #redirect_to root_path
	      redirect_back_or root_path
	end

    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
