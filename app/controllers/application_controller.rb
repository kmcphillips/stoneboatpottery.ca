# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include ApplicationHelper  # I don't know why this is needed

  helper_method :lineage

  before_filter :load_sidebar_images

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def require_login
    unless session[:admin_user]
      flash[:error] = "You must login to view that page."
      redirect_to "/admin/login"
    end
  end

protected

  def load_sidebar_images
    @sidebar_images = Image.recent 5
  end
end
