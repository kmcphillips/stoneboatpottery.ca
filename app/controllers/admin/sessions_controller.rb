class Admin::SessionsController < ApplicationController

  def index
    redirect_to "/admin/login"
  end

  def new
    @title = "Admin Login"
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    
    if user
      session[:admin_user] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to admin_posts_path
    else
      flash[:error] = "Username and password are incorrect."
      redirect_to "/admin/login"
    end
  end

  def destroy
    flash[:notice] = "You have been logged out."
    session[:admin_user] = nil
    redirect_to "/"
  end
  
  def logout
    destroy
  end

end
