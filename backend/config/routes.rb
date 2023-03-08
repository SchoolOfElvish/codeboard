# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      post '/sign-up', to: 'sessions#sign_up'
      post '/sign-in', to: 'sessions#sign_in'
      post '/sign-out', to: 'sessions#sign_out'
      resource :users, only: [:update] do
        put 'me', to: 'users#update'
      end
      post '/refresh', to: 'sessions#refresh'
      resources :courses, only: [:create] do
        resources :lessons, only: [:create]
      end
    end
  end
end
