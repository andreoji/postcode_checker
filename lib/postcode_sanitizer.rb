# frozen_string_literal: true

class PostcodeSanitizer
  def self.sanitize(postcode)
    postcode.delete(' ').downcase
  end
end
