class LinksController < ApplicationController

  def index
    @links = Link.all(:order => "updated_at DESC")
  end

end
