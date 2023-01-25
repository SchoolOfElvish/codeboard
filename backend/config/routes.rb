Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get '/sign_up', to: 'sessions#sign_up'
      get '/sign_in', to: 'sessions#sign_in'
      get '/sign_out', to: 'sessions#sign_out'
    end
  end
end
