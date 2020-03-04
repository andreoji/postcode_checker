# frozen_string_literal: true

class LsoaWhitelist
  def initialize(lsoa_whitelist = nil)
    @lsoa_whitelist = lsoa_whitelist || ENV.fetch('LSOA_WHITELIST')
  end

  def whitelisted?(lsoa)
    return false unless lsoa

    lsoa_whitelist.split(';').any? { |e| lsoa.starts_with? e }
  end

  private

  attr_reader :lsoa_whitelist
end
