class LinksController < ApplicationController

  def index
    @links = Link.order("updated_at DESC")
    @title = "Links"
  end

end
