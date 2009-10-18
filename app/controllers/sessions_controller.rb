class SessionsController < ApplicationController

  def index
    redirect_to "/login"
  end

  def new
    @title = "Wholesale Login"
  end

  def create
    pw = WholesalePassword.find_by_password(params[:password])

    if pw
      if pw.usable?
        session[:wholesale_permitted] = true
        flash[:notice] = "Logged in successfully."
        redirect_to "/wholesale"
      else
        flash[:error] = "Password has expired."
        redirect_to "/login"
      end
    else
      flash[:error] = "Password is incorrect."
      redirect_to "/login"
    end
  end

  def destroy
    flash[:notice] = "You have been logged out."
    session[:wholesale_permitted] = nil
    redirect_to "/"
  end
  
  def logout
    destroy
  end

end
