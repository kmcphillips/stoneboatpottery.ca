class AuthenticatedController < ApplicationController
  before_filter :require_login

  protected

  def require_login
    except = require_login_except rescue []

    unless session[:admin_user] || except.include?(params[:action])
      flash[:error] = "You must login to view that page."
      redirect_to "/admin/login"
    end
  end

end
