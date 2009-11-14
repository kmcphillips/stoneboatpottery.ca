module ApplicationHelper

  def current_user
    User.find(session[:admin_user]) if session[:admin_user]
  end

  def wholesale?
    !! (session[:wholesale_permitted] || current_user)
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

  def index_entity_image(path, label=nil, args={})
    html = link_to(image_tag("/images/icons/index.png", :alt => "Index"), path, :title => "Index")
    html += " " + link_to(label, path) if label
    html
  end
  
  def new_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/new.png", :alt => "New"), path, :title => "New"
    html += " " + link_to(label, path) if label
    html
  end

  def delete_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/delete.png", :alt => "Delete", :class => "action-image"), path, :method => :delete, :confirm => "Are you sure you want to delete this?", :title => "Delete"
    html += " " + link_to(label, path, :method => :delete, :confirm => "Are you sure you want to delete this?") if label
    html
  end

  def edit_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/edit.png", :alt => "Edit", :class => "action-image"), path, :title => "Edit"
    html += " " + link_to(label, path) if label
    html
  end

end
