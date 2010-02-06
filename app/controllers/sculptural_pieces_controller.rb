class SculpturalPiecesController < ApplicationController
  
  def index
    @pieces = SculpturalPiece.active.paginate(:per_page => 10, :page => params[:page] || 1)
    @inactive_pieces = SculpturalPiece.inactive
    @title = "Sculptural Pieces"
  end

  def show
    @piece = SculpturalPiece.find_by_permalink(params[:id])

    if @piece && (@piece.active? || current_user)
      flash[:warning] = "This piece is not active and can't be seen by users other than you." unless @piece.active?
      @title = @piece.name
    else
      redirect_to_404
    end  
  end

end
