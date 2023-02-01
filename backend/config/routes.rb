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
      post '/refresh', to: 'sessions#refresh'
      post 'hello', to: 'sessions#hello'
      post 'users/me', to: 'users#update'
    end
  end
end
