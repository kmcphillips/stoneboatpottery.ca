class Admin::SculpturalPiecesController < ApplicationController
  before_filter :require_login
  
  def index
    @pieces = SculpturalPiece.all(:order => "active DESC, updated_at DESC")
    @title = "Sculptural Pieces"
  end

  def new
    @piece = SculpturalPiece.new
    @title = "New Sculptural Piece"
  end
  
  def show
    @piece = SculpturalPiece.find_by_permalink(params[:id])
    redirect_to sculptural_piece_path(@piece)
  end
  
  def edit
    @piece = SculpturalPiece.find_by_permalink(params[:id])
    @title = "Edit #{@piece.name}"
  end
  
  def update
    @piece = SculpturalPiece.find_by_permalink(params[:id])
    
    if @piece.update_attributes(params[:sculptural_piece])
      flash[:notice] = "Piece successfully updated."
      redirect_to admin_sculptural_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/sculptural_pieces/edit'
    end      
  end

  def create
    @piece = SculpturalPiece.new(params[:sculptural_piece])
    
    if @piece.save
      flash[:notice] = "Piece successfully created."
      redirect_to admin_sculptural_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/sculptural_pieces/new'
    end  
  end

  def destroy
    piece = SculpturalPiece.find_by_permalink(params[:id])

    if piece.delete
      flash[:notice] = "Piece successfully deleted."
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
    end

    redirect_to admin_sculptural_pieces_path
  end
  
end
