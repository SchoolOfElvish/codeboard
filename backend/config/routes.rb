# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      post '/sign-up', to: 'sessions#sign_up'
      post '/sign-in', to: 'sessions#sign_in'
      delete '/sign-out', to: 'sessions#sign_out'
      get 'users/me', to: 'profiles#show'
      put 'users/me', to: 'profiles#update'
      post '/refresh', to: 'sessions#refresh'
      post 'test', to: 'test#update'
      put 'attach_avatar', to: 'test#attach_avatar'
        
      resources :courses, only: %i[create index] do
        resources :lessons, only: [:create]
      end
      resources :groups, only: [:create]
      resources :users, only: [:show]
    end
  end
end
