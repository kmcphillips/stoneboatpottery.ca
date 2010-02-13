class Admin::FunctionalPiecesController < ApplicationController
  before_filter :require_login
  
  def index
    @pieces = FunctionalPiece.all(:order => "active DESC, updated_at DESC")
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
    
    if @piece.update_attributes(params[:functional_piece])
      flash[:notice] = "Piece successfully updated."
      redirect_to admin_functional_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/functional_pieces/edit'
    end      
  end

  def create
    @piece = FunctionalPiece.new(params[:functional_piece])
    
    if @piece.save
      flash[:notice] = "Piece successfully created."
      redirect_to admin_functional_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/functional_pieces/new'
    end  
  end

  def destroy
    piece = FunctionalPiece.find_by_permalink(params[:id])

    if piece.delete
      flash[:notice] = "Piece successfully deleted."
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
    end

    redirect_to admin_functional_pieces_path
  end

  
  def lineage
    [:admin, FunctionalPiece.find_by_permalink(params[:id]) || FunctionalPiece.new]
  end
  
end
