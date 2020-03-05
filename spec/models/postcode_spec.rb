# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Postcode, type: :model do
  subject(:postcode) { described_class.create!(postcode: 'sh241aa') }

  describe '.whitelisted?' do
    let(:whitelist) { described_class.all.map(&:postcode) }

    before do
      FactoryBot.create :postcode, postcode: 'SH24 1AA'
      FactoryBot.create :postcode, postcode: 'sh241ab'
    end

    it { expect(described_class.whitelisted?(whitelist.first.downcase)).to be true }
    it { expect(described_class.whitelisted?(whitelist.last.upcase)).to be true }
    it { expect(described_class.whitelisted?('g36lg')).to be false }
  end
end
