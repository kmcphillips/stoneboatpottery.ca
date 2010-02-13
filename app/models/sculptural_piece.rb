class SculpturalPiece < Piece

  xss_terminate :except => [:permalink, :type]

  def display_type(plural=false)
    "sculptural piece#{plural ? "s" : ""}"
  end
end