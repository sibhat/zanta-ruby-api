# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }, path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  devise_scope :user do
    post '/users/token', to: 'users/token#create'
  end
end
