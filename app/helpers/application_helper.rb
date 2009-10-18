module ApplicationHelper
  def current_user
    User.find(session[:admin_user]) if session[:admin_user]
  end

  def wholesale?
    !! session[:wholesale_permitted]
  end

  def page_title
    prefix = "Stoneboat Pottery"
    prefix = "#{prefix} - Admin" if params[:controller] =~ /^admin\//

    if @title
      "#{prefix} - #{@title}"
    elsif params[:controller] == "blocks"
      "#{prefix} - #{params[:action].humanize}"
    else
      prefix
    end
  end

end
