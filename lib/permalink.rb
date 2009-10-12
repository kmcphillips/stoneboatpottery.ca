module Permalink
  def generate_permalink_for(obj, text)
    text = text.downcase.strip.gsub(/[^a-z0-9\w]/, "_").sub(/_+$/, "").sub(/^_+/, "")
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