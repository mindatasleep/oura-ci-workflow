Rails.application.routes.draw do
  resources :ouras
  resources :workouts
  devise_for :users
  # get 'oura/index'

  
  
  get 'pages/index'
  root to: 'pages#index'

  
  get '/oura/userinfo', to: 'ouras#userinfo'
  get '/oura/login', to: 'ouras#oura_cloud_authorization'
  get '/oura/callback', to: 'ouras#callback'
  get '/ouras/', to: 'ouras#index'
  get '/picknick/', to: 'pages#picknick'
  get '/airtable/', to: 'pages#airtable'
  # match "/patients/:id" => "patients#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
