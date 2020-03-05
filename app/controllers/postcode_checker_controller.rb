# frozen_string_literal: true

class PostcodeCheckerController < ApplicationController
  OUTWITH_SERVICE_AREA = 'The postcode is outwith the service area'
  WITHIN_SERVICE_AREA = 'The postcode is within the service area'
  def search
    postcode = PostcodeSanitizer.sanitize params[:postcode]
    if postcode == ''
      flash[:notice] = 'Invalid input'
    elsif Postcode.whitelisted? postcode
      flash[:notice] = WITHIN_SERVICE_AREA
    else
      result = PostcodesIoService.new.find postcode
      flash[:notice] = message result
    end
    render :index
  end

  private

  def message(result)
    case result[:status]
    when 200
      LsoaWhitelist.new.whitelisted?(result[:lsoa]) ? WITHIN_SERVICE_AREA : OUTWITH_SERVICE_AREA
    when 404
      result[:error]
    else
      'Oops! Something went wrong!'
    end
  end
end
