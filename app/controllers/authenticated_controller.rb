class AuthenticatedController < ApplicationController
  before_filter :require_login, :check_read_only

  protected

  def require_login
    except = require_login_except rescue []

    unless session[:admin_user] || except.include?(params[:action])
      flash[:error] = "You must login to view that page."
      redirect_to "/admin/login"
    end
  end

  def read_only?
    false
  end

  def check_read_only
    if read_only?
      flash[:notice] = "You cannot login at this time. Site temporarily in read-only mode."
      session[:admin_user] = nil
      redirect_to root_path
    end

    true
  end
end
