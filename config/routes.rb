Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  resources :tree, only: :index
  resources :links
  resources :users
  resources :payments
  get '/about', to: 'public#about', as: 'about'
  get '/pricing', to: 'public#pricing', as: 'pricing'
  get '/features', to: 'public#features', as: 'features'
  get '/product', to: 'public#product', as: 'product'
  get 'verifications', to: 'verifications#index'
  post 'verifications/verify', to: 'verifications#verify'
end
