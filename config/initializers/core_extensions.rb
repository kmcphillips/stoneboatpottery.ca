class String
  def upcase_words
    self.split(' ').map {|w| w.capitalize }.join(' ')
  end
end