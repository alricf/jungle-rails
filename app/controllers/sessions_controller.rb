class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save user id inside the browser cookie.
      session[:user_id] = user.id
      redirect_to '/'
    else
      # If user login doesn't work then go back to login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
  
end
  