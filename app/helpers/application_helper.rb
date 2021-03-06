module ApplicationHelper

  def current_user
    User.find(session[:admin_user]) if session[:admin_user]
  end

  def page_title
    prefix = "Stoneboat Pottery"
    prefix = "#{prefix} - Admin" if params[:controller] =~ /^admin\//

    if @title
      "#{prefix} - #{@title}"
    elsif params[:controller] =~ /blocks$/
      "#{prefix} - #{params[:action].humanize}"
    else
      prefix
    end
  end

  def boolean_wrapper(value)
    content_tag(:span, (value ? "Yes" : "No"), :class => "boolean_#{!!value}")
  end

  # Action image helpers

  def index_entity_image(path, label=nil, args={})
    html = link_to(image_tag("/images/icons/index.png", :alt => "Index"), path, :title => "Index")
    html += " ".html_safe + link_to(label, path) if label
    html.html_safe
  end

  def new_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/new.png", :alt => "New"), path, :title => "New"
    html += " ".html_safe + link_to(label, path) if label
    html.html_safe
  end

  def delete_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/delete.png", :alt => "Delete", :class => "action-image"), path, :method => :delete, data: { :confirm => "Are you sure you want to delete this?" }, :title => "Delete"
    html += " ".html_safe + link_to(label, path, :method => :delete, data: { :confirm => "Are you sure you want to delete this?" }) if label
    html.html_safe
  end

  def edit_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/edit.png", :alt => "Edit", :class => "action-image"), path, :title => "Edit"
    html += " ".html_safe + link_to(label, path) if label
    html.html_safe
  end

  def show_entity_image(path, label=nil, args={})
    html = link_to image_tag("/images/icons/show.png", :alt => "Show", :class => "action-image"), path, :title => "Show"
    html += " ".html_safe + link_to(label, path) if label
    html.html_safe
  end

  # Shortcuts for images in posts

  def images_for(imageable, options={})
    if imageable && imageable.respond_to?(:image) && imageable.image
      link_to(image_tag(imageable.image.inline, :alt => ALT_TAG_DEFAULT) + "<br />".html_safe + enlarge_button, imageable.image.full, :rel => :facebox, :class => (options[:align] && options[:align].to_s == "right"? "float-right no_underline" : "float-left no_underline"))
    elsif imageable && imageable.respond_to?(:images) && imageable.images.any?
      render :partial => 'shared/show_images', :object => imageable
    end
  end

  def thumb_for(image, path, options={})
    {:alt => ALT_TAG_DEFAULT}.merge(options)

    if image
      link_to(image_tag(image.thumb, :alt => options[:alt]), path, :class => :no_underline)
    else
      link_to(image_tag(THUMB_NOT_FOUND_IMAGE, :alt => options[:alt]), path, :class => :no_underline)
    end
  end

  def enlarge_button
    "Enlarge".html_safe + image_tag("/images/icons/magnify.png", :alt => "Enlarge", :class => :magnify)
  end

  def redirect_to_404
    redirect_to "/404.html"
  end

  def safe_mail_to(email, label=nil)
    obfuscated = email.scan(/.{1,10}/).join("[REMOVE_THIS]")
    mail_to(email, label, :encode => "javascript") + "<noscript>#{mail_to(obfuscated, label || email.sub(/\@.*/, ""))}</noscript>".html_safe
  end

  def boolean_image(value)
    image_tag("/images/icons/#{!!value}.png", :alt => (!!value).to_s.humanize)
  end
end
