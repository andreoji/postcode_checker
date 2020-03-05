# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodesIoService do
  subject(:service) { described_class.new(base_url) }

  let(:base_url) { 'http://api.postcodes.io/postcodes' }

  context 'with a valid postcode' do
    let(:valid_postcode) { 'g36lg' }
    let(:valid_body) {
      {
        'status' => 200,
        'result' => { 'postcode' => 'G3 6LG', 'lsoa' => 'Woodlands - 05' }
      }
    }
    let(:response) {
      instance_double('HTTParty::Response', code: 200, body: valid_body.to_json)
    }

    it 'returns a 200 result' do
      allow(HTTParty).to receive(:get)
        .with("#{base_url}/#{valid_postcode}")
        .and_return(response)

      result = service.find(valid_postcode)

      expect(result).to eq({ status: 200, lsoa: 'Woodlands - 05', postcode: 'G3 6LG' })
    end
  end

  context 'with an invalid postcode' do
    let(:invalid_postcode) { 'x21z' }
    let(:invalid_body) {
      {
        'status' => 404,
        'error' => 'Invalid postcode'
      }
    }
    let(:response) {
      instance_double('HTTParty::Response', code: 404, body: invalid_body.to_json)
    }

    it 'returns a 404 error' do
      allow(HTTParty).to receive(:get)
        .with("#{base_url}/#{invalid_postcode}")
        .and_return(response)

      result = service.find(invalid_postcode)

      expect(result).to eq({ status: 404, error: 'Invalid postcode' })
    end
  end
end
