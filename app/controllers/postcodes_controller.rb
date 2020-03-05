# frozen_string_literal: true

class PostcodesController < ApplicationController
  before_action :find_postcode, only: :destroy

  def index
    @postcodes = Postcode.all.order(:postcode)
  end

  def create
    @postcode = Postcode.new(postcode_params)
    if @postcode.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    @postcode.destroy
    redirect_to postcodes_path
  end

  private

  def postcode_params
    params.require(:postcode).permit(:postcode)
  end

  def find_postcode
    @postcode = Postcode.find(params[:id])
  end
end
