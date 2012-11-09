class PaperPiecesController < ApplicationController

  def index
    @pieces = PaperPiece.active.sorted.paginate(:per_page => 10, :page => params[:page] || 1)
    @inactive_pieces = PaperPiece.inactive
    @title = "Works on Paper"
    render "pieces/index"
  end

  def show
    @piece = PaperPiece.find_by_permalink(params[:id])

    if @piece && (@piece.active? || current_user)
      flash[:warning] = "This piece is not active and can't be seen by users other than you." unless @piece.active?
      @title = @piece.name
      render "pieces/show"
    else
      redirect_to_404
    end
  end


  def lineage
    [@piece || PaperPiece.new]
  end
end
