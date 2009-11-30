class PiecesController < ApplicationController
  
  def index
    @pieces = Piece.active.paginate(:per_page => 10, :page => params[:page] || 1)
    @title = "Pieces"
  end

  def show
    @piece = Piece.find_by_permalink(params[:id])
    @title = @piece.name
  end

end
