module Permalink

  MAX_LENGTH = 60

  def generate_permalink_for(obj, text)
    text = text.downcase.strip.gsub(/[^a-z0-9\w]/, "_").sub(/_+$/, "").sub(/^_+/, "")[0..MAX_LENGTH]
    raise StandardError, "String must contain some alpha-numeric characters" if text.length == 0
    if obj.class.find_by_permalink(text)
      num = 1
      
      while obj.class.find_by_permalink(text + num.to_s)
        num += 1
      end
      
      text = text + num.to_s
    end
    text
  end
end
