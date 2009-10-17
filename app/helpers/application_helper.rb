module ApplicationHelper
  def current_user
    User.find(session[:admin_user]) if session[:admin_user]
  end

  def wholesale?
    !! session[:wholesale_permitted]
  end
end
