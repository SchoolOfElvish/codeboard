# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      post '/sign-up', to: 'sessions#sign_up'
      post '/sign-in', to: 'sessions#sign_in'
      post '/sign-out', to: 'sessions#sign_out'
      resource :users, only: [:update] do
        put 'me', to: 'users#update'
      end
      post '/refresh', to: 'sessions#refresh'
      post 'hello', to: 'sessions#hello'
      resources :courses
    end
  end
end
