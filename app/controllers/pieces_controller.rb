class PiecesController < ApplicationController
  
  def index
    @pieces = Piece.all(:order => "updated_at DESC")
    @title = "Pieces"
  end

  def show
    @piece = Piece.find_by_permalink(params[:id])
    @title = @piece.name
  end

end
