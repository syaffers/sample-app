class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by( email: params[:session][:email].downcase )
    if user && user.authenticate(params[:session][:password])
      # Sign in and redir to user page
      sign_in user
      redirect_to user
    else
      # Error msg and go back to form
      flash.now[:error] = "Invalid email/password combination"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end
