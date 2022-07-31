# frozen_string_literal: true

Rails.application.routes.draw do

  # Rswag
  mount Rswag::Ui::Engine  => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  # Routes
  # Front-end Routes
  root to: 'home#index'
  resources :places

  # API
  namespace :api, constraint: { subdomain: 'api' } do
    namespace :v1 do
      defaults format: :json do
        resources :addresses
        resources :cities
        resources :places
        resources :regions
        resources :routes
        resources :states
      end
    end
  end
end
