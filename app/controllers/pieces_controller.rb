class PiecesController < ApplicationController
  
  def index
    @pieces = Piece.active.paginate(:per_page => 10, :page => params[:page] || 1)
    @inactive_pieces = Piece.inactive
    @title = "Pieces"
  end

  def show
    @piece = Piece.find_by_permalink(params[:id])

    if @piece && (@piece.active? || current_user)
      flash[:warning] = "This piece is not active and can't be seen by users other than you." unless @piece.active?
      @title = @piece.name
    else
      redirect_to_404
    end  
  end

end
