class Admin::SessionsController < ApplicationController
  before_filter :require_login

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

  def password
  end

  def logout
    destroy
  end

  def change_password
    @user = current_user
    
    if @user.change_password!(params[:password], params[:password_confirm])
      flash[:error] = @user.errors.full_messages.to_sentence
    else
      flash[:notice] = "Password was changed successfully."
    end

    redirect_to password_admin_sessions_path
  end

  protected

  def require_login_except
    ["index", "new", "create", "destroy", "logout"]
  end

end
