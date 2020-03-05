# frozen_string_literal: true

class Postcode < ApplicationRecord
  before_validation :normalize_postcode
  validates :postcode, presence: true, uniqueness: true

  def self.whitelisted?(postcode)
    return false unless postcode

    postcode = PostcodeSanitizer.sanitize postcode
    exists?(postcode: postcode)
  end

  private

  def normalize_postcode
    self.postcode = postcode.delete(' ').downcase
  end
end
