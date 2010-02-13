class FunctionalPiece < Piece

  xss_terminate :except => [:permalink, :type]

  def display_type(plural=false)
    "funky functional piece#{plural ? "s" : ""}"
  end
end