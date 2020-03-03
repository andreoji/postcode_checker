# frozen_string_literal: true

class PostcodesIoService
  def initialize(base_url = nil)
    @base_url = base_url || ENV.fetch('POSTCODES_IO_API_URL')
  end

  def find(postcode)
    postcode = postcode.delete(' ').downcase
    response = HTTParty.get "#{base_url}/#{postcode}"
    parse_response response
  end

  private

  attr_reader :base_url

  def parse_response(response)
    response.code == 200 ? success_json(response) : error_json(response)
  end

  def success_json(response)
    json = JSON.parse(response.body)
    { status: json.dig('status'), lsoa: json.dig('result', 'lsoa'), postcode: json.dig('result', 'postcode') }
  end

  def error_json(response)
    json = JSON.parse(response.body)
    { status: json.dig('status'), error: json.dig('error') }
  end
end
