class SculpturalPiece < Piece

  date_scopes

  def display_type(plural=false)
    "sculptural piece#{plural ? "s" : ""}"
  end
end