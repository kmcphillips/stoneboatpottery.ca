class SculpturalPiece < Piece

  def display_type(plural=false)
    "sculptural piece#{plural ? "s" : ""}"
  end
end