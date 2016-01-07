class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email and/or password.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'You have logged out. See you around!'
    redirect_to root_url
  end

end
