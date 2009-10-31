class Admin::PiecesController < ApplicationController
  before_filter :require_login
  
  def index
    @pieces = Piece.all(:order => "active DESC, updated_at DESC")
    @title = "Pieces"
  end

  def new
    @piece = Piece.new
    @title = "New Piece"
  end
  
  def show
    @piece = Piece.find_by_permalink(params[:id])
    redirect_to piece_path(@piece)
  end
  
  def edit
    @piece = Piece.find_by_permalink(params[:id])
    @title = "Edit #{@piece.name}"
  end
  
  def update
    @piece = Piece.find_by_permalink(params[:id])
    
    if @piece.update_attributes(params[:piece])
      flash[:notice] = "Piece successfully updated."
      redirect_to admin_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/pieces/edit'
    end      
  end

  def create
    @piece = Piece.new(params[:piece])
    
    if @piece.save
      flash[:notice] = "Piece successfully created."
      redirect_to admin_pieces_path
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
      render 'admin/pieces/new'
    end  
  end

  def destroy
    piece = Piece.find_by_permalink(params[:id])

    if piece.delete
      flash[:notice] = "Piece successfully deleted."
    else
      flash[:error] = @piece.errors.full_messages.to_sentence
    end

    redirect_to admin_pieces_path
  end
  
end
