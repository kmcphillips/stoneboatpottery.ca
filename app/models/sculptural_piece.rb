class SculpturalPiece < Piece

  xss_terminate :except => [:permalink, :type]

  date_scopes

  def display_type(plural=false)
    "sculptural piece#{plural ? "s" : ""}"
  end
end