class FunctionalPiece < Piece

  def display_type(plural=false)
    "funky functional piece#{plural ? "s" : ""}"
  end
end