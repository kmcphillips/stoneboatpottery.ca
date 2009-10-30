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

  def index_entity_image(path, args={})
    link_to path, :title => "Index" do
      image_tag "/images/icons/index.png", :alt => "Index"
    end
  end
  
  def new_entity_image(path, args={})
    link_to path, :title => "New" do
      image_tag "/images/icons/new.png", :alt => "New"
    end
  end

  def delete_entity_image(path, args={})
    link_to path, :method => :delete, :confirm => "Are you sure you want to delete this?", :title => "Delete" do
      image_tag "/images/icons/delete.png", :alt => "Delete", :class => "action-image"
    end
  end

  def edit_entity_image(path, args={})
    link_to path, :title => "Edit" do
      image_tag "/images/icons/edit.png", :alt => "Edit", :class => "action-image"
    end
  end

end
