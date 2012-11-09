class FunctionalPiecesController < ApplicationController

  def index
    @pieces = FunctionalPiece.active.sorted.paginate(:per_page => 10, :page => params[:page] || 1)
    @inactive_pieces = FunctionalPiece.inactive
    @title = "Funky Functional Pieces"
    render "pieces/index"
  end

  def show
    @piece = FunctionalPiece.find_by_permalink(params[:id])

    if @piece && (@piece.active? || current_user)
      flash[:warning] = "This piece is not active and can't be seen by users other than you." unless @piece.active?
      @title = @piece.name
      render "pieces/show"
    else
      redirect_to_404
    end
  end


  def lineage
    [@piece || FunctionalPiece.new]
  end
end
