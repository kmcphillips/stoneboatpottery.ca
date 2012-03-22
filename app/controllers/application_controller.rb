class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  include ApplicationHelper

  helper_method :lineage

  before_filter :load_sidebar_images
  
  def require_login
    except = require_login_except rescue []

    unless session[:admin_user] || except.include?(params[:action])
      flash[:error] = "You must login to view that page."
      redirect_to "/admin/login"
    end
  end

  ## Handle custom dynamic errors
  unless StoneboatpotteryCa::Application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownAction, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end

  def render_500
    logger.error "#{$!.class.to_s}: #{$!}"
    logger.error $!.backtrace.join("\n")
    render_error(500)
  end
  
  def render_404
    render_error(404)
  end

protected

  def render_error(code)
    render :template => "shared/errors/#{code}", :status => :not_found
  end

  def load_sidebar_images
    @sidebar_images = Image.recent 5
  end
end
