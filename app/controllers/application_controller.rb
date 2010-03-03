class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  include ApplicationHelper

  helper_method :lineage

  before_filter :load_sidebar_images

  filter_parameter_logging :password, :password_confirm
  
  def require_login
    except = require_login_except rescue []

    unless session[:admin_user] || except.include?(params[:action])
      flash[:error] = "You must login to view that page."
      redirect_to "/admin/login"
    end
  end

protected

  def load_sidebar_images
    @sidebar_images = Image.recent 5
  end
end
