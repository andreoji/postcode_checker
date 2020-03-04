# frozen_string_literal: true

require 'rails_helper'
require 'lsoa_whitelist'

RSpec.describe LsoaWhitelist do
  subject(:lsoa_whitelist) { described_class.new }

  context 'when lsoa is in the whitlelist' do
    it 'returns true' do
      expect(lsoa_whitelist.whitelisted?('Southwark 034A')).to eq true
    end
  end

  context "when lsoa isn't the whitlelist" do
    it 'returns false' do
      expect(lsoa_whitelist.whitelisted?('Woodlands - 05')).to eq false
    end
  end
end
