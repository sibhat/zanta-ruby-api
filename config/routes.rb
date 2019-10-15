# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }, path: 'api/v1', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :businesses, only: %i[show destroy update]
      resources :customers, only: %i[show destroy update]
    end
  end
  devise_scope :user do
    post '/api/v1/token', to: 'users/token#create'
    post '/api/v1/register/businesses' => 'users/token#create_business'
    post '/api/v1/register/customers' => 'users/token#create_customer'
  end
end
