# frozen_string_literal: true

class Postcode < ApplicationRecord
  before_validation :sanitize_postcode
  validates :postcode, presence: true, uniqueness: true

  def self.whitelisted?(postcode)
    return false unless postcode

    postcode = PostcodeSanitizer.sanitize postcode
    exists?(postcode: postcode)
  end

  private

  def sanitize_postcode
    self.postcode = PostcodeSanitizer.sanitize postcode
  end
end
