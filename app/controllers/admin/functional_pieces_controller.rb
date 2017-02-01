class Admin::FunctionalPiecesController < AuthenticatedController

  def index
    @pieces = FunctionalPiece.sorted
    @title = "Edit Funky Functional Pieces"
    render 'admin/pieces/index'
  end

  def new
    @piece = FunctionalPiece.new
    @title = "New Funky Functional Piece"
    render 'admin/pieces/new'
  end

  def show
    @piece = FunctionalPiece.find_by_permalink(params[:id])
    redirect_to functional_piece_path(@piece)
  end

  def edit
    @piece = FunctionalPiece.find_by_permalink(params[:id])
    @title = "Edit #{@piece.name}"
    render 'admin/pieces/edit'
  end

  def update
    @piece = FunctionalPiece.find_by_permalink(params[:id])

    if @piece.update_attributes(functional_piece_params)
      flash[:notice] = "Piece successfully updated."
      redirect_to admin_functional_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/pieces/edit'
    end
  end

  def create
    @piece = FunctionalPiece.new(functional_piece_params)

    if @piece.save
      flash[:notice] = "Piece successfully created."
      redirect_to admin_functional_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/pieces/new'
    end
  end

  def destroy
    @piece = FunctionalPiece.find_by_permalink(params[:id])

    if @piece.delete
      flash[:notice] = "Piece successfully deleted."
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
    end

    redirect_to admin_functional_pieces_path
  end

  def lineage
    [:admin, @piece || FunctionalPiece.new]
  end

  private

  def functional_piece_params
    params.permit![:functional_piece]
  end
end
