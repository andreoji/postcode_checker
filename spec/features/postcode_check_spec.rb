# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Postcode check', type: :feature do
  context 'with a whitelisted postcode' do
    it 'successfully checks the service area' do
      Postcode.create!(postcode: 'sh241aa')
      visit root_path
      fill_in 'Postcode', with: 'SH24 1AA'
      click_button 'Check postcode'
      expect(page).to have_text('The postcode is within the service area')
    end
  end

  context 'with a whitelisted lsoa' do
    let(:lsoa_postcode) { 'SE1 7QD' }
    let(:response) { { status: 200, lsoa: 'Southwark 034A', postcode: lsoa_postcode } }
    let(:service) { instance_double(PostcodesIoService) }

    it 'successfully checks the service area' do
      allow(service).to receive(:find)
        .with(lsoa_postcode)
        .and_return(response)

      visit root_path
      fill_in 'Postcode', with: lsoa_postcode
      click_button 'Check postcode'
      expect(page).to have_text('The postcode is within the service area')
    end
  end

  context 'when postcode is outwith the service area' do
    let(:outwith_service_area_postcode) { 'G3 6LG' }
    let(:response) { { status: 200, lsoa: 'Woodlands - 05', postcode: outwith_service_area_postcode } }
    let(:service) { instance_double(PostcodesIoService) }

    it 'unsuccessfully checks the service area' do
      allow(service).to receive(:find)
        .with(outwith_service_area_postcode)
        .and_return(response)

      visit root_path
      fill_in 'Postcode', with: outwith_service_area_postcode
      click_button 'Check postcode'
      expect(page).to have_text('The postcode is outwith the service area')
    end
  end

  context 'when postcode is invalid' do
    let(:invalid_postcode) { 'invalid' }
    let(:response) { { status: 404, error: 'Invalid postcode!' } }
    let(:service) { instance_double(PostcodesIoService) }

    it 'invalid check of service area' do
      allow(service).to receive(:find)
        .with(invalid_postcode)
        .and_return(response)

      visit root_path
      fill_in 'Postcode', with: invalid_postcode
      click_button 'Check postcode'
      expect(page).to have_text('Invalid postcode')
    end
  end
end
