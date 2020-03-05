# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Managing the postcode whitelist', type: :feature do
  context 'with an existing postcode in the whitelist' do
    before do
      Postcode.create!(postcode: 'SH24 1AA')
    end

    it 'will not allow the user to whitelist the same postcode' do
      visit postcodes_path
      click_link 'Add new postcode'
      fill_in 'Postcode', with: 'SH24 1AA'
      click_button 'Add new postcode'
      expect(page).to have_text('Postcode has already been taken')
    end

    it 'allows the user to delete the existing postcode' do
      visit postcodes_path
      click_link 'Delete'
      expect(page).not_to have_content('sh241aa')
    end
  end

  context 'when a new postcode is added to the whitelist then checked' do
    it 'successfully checks the service area' do
      visit postcodes_path
      click_link 'Add new postcode'
      fill_in 'Postcode', with: 'SH24 1AA'
      click_button 'Add new postcode'
      visit root_path
      fill_in 'Postcode', with: 'SH24 1AA'
      click_button 'Check postcode'
      expect(page).to have_text('The postcode is within the service area')
    end
  end
end
