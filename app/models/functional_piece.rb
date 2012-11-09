class FunctionalPiece < Piece

  date_scopes

  def display_type(plural=false)
    "funky functional piece#{plural ? "s" : ""}"
  end
end