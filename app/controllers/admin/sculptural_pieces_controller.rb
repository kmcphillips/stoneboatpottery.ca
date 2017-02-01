class Admin::SculpturalPiecesController < AuthenticatedController

  def index
    @pieces = SculpturalPiece.sorted
    @title = "Edit Sculptural Pieces"
    render 'admin/pieces/index'
  end

  def new
    @piece = SculpturalPiece.new
    @title = "New Sculptural Piece"
    render 'admin/pieces/new'
  end

  def show
    @piece = SculpturalPiece.find_by_permalink(params[:id])
    redirect_to sculptural_piece_path(@piece)
  end

  def edit
    @piece = SculpturalPiece.find_by_permalink(params[:id])
    @title = "Edit #{@piece.name}"
    render 'admin/pieces/edit'
  end

  def update
    @piece = SculpturalPiece.find_by_permalink(params[:id])

    if @piece.update_attributes(sculptural_piece_params)
      flash[:notice] = "Piece successfully updated."
      redirect_to admin_sculptural_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/sculptural_pieces/edit'
    end
  end

  def create
    @piece = SculpturalPiece.new(sculptural_piece_params)

    if @piece.save
      flash[:notice] = "Piece successfully created."
      redirect_to admin_sculptural_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/sculptural_pieces/new'
    end
  end

  def destroy
    @piece = SculpturalPiece.find_by_permalink(params[:id])

    if @piece.delete
      flash[:notice] = "Piece successfully deleted."
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
    end

    redirect_to admin_sculptural_pieces_path
  end


  def lineage
    [:admin, @piece || SculpturalPiece.new]
  end

  private

  def sculptural_piece_params
    params.permit![:sculptural_piece]
  end
end
