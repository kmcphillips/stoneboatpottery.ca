class PaperPiece < Piece

  date_scopes

  def display_type(plural=false)
    "work#{plural ? "s" : ""} on paper"
  end
end