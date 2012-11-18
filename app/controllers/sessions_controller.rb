class SessionsController < ApplicationController
  #skip_authorization_check 
  def new
    if session[:user_id]
      redirect_to :articles
      return
    end
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :articles, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end


  
end
