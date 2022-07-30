# frozen_string_literal: true

Rails.application.routes.draw do

  # Dashboard
  namespace :dashboard, constraint: { subdomain: 'api'} do
    # To be implemented
  end

  # Routes
  resources :places

  # API
  namespace :api, constraint: { subdomain: 'api' } do
    namespace :v1 do
      defaults format: :json do
      end
    end
  end
end
