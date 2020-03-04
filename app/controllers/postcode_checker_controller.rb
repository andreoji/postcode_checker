# frozen_string_literal: true

class PostcodeCheckerController < ApplicationController
  OUTWITH_SERVICE_AREA = 'The postcode is outwith the service area.'
  def search
    result = PostcodesIoService.new.find(params[:postcode])
    flash[:notice] = message result
    render :index
  end

  private

  def message(result)
    case result[:status]
    when 200
      LsoaWhitelist.new.whitelisted?(result[:lsoa]) ? 'The postcode is within the service area.' : OUTWITH_SERVICE_AREA
    when 404
      OUTWITH_SERVICE_AREA
    else
      OUTWITH_SERVICE_AREA
    end
  end
end
