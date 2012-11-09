class Admin::PaperPiecesController < ApplicationController
  before_filter :require_login

  def index
    @pieces = PaperPiece.sorted
    @title = "Edit Works on Paper"
    render 'admin/pieces/index'
  end

  def new
    @piece = PaperPiece.new
    @title = "New Work on Paper"
    render 'admin/pieces/new'
  end

  def show
    @piece = PaperPiece.find_by_permalink(params[:id])
    redirect_to paper_piece_path(@piece)
  end

  def edit
    @piece = PaperPiece.find_by_permalink(params[:id])
    @title = "Edit #{@piece.name}"
    render 'admin/pieces/edit'
  end

  def update
    @piece = PaperPiece.find_by_permalink(params[:id])

    if @piece.update_attributes(params[:paper_piece])
      flash[:notice] = "Work on paper successfully updated."
      redirect_to admin_paper_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/pieces/edit'
    end
  end

  def create
    @piece = PaperPiece.new(params[:paper_piece])

    if @piece.save
      flash[:notice] = "Work on paper successfully created."
      redirect_to admin_paper_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/pieces/new'
    end
  end

  def destroy
    @piece = PaperPiece.find_by_permalink(params[:id])

    if @piece.delete
      flash[:notice] = "Work on paper successfully deleted."
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
    end

    redirect_to admin_paper_pieces_path
  end


  def lineage
    [:admin, @piece || PaperPiece.new]
  end

end
