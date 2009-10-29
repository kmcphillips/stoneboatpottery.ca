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

  # Action image helpers
  
  def new_entity_image(path, args={})
    link_to path do
      image_tag "/images/icons/new.png", :alt => "New"
    end
  end

  def delete_entity_image(path, args={})
    link_to path, :method => :post, :confirm => "Are you sure you want to delete this?" do
      image_tag "/images/icons/delete.png", :alt => "Delete", :class => "action-image"
    end
  end

  def edit_entity_image(path, args={})
    link_to path do
      image_tag "/images/icons/edit.png", :alt => "Edit", :class => "action-image"
    end
  end

end
