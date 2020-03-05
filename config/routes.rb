# frozen_string_literal: true

Rails.application.routes.draw do
  root 'postcode_checker#index'
  get 'postcode_checker/search', to: 'postcode_checker#search'

  resources :postcodes
end
