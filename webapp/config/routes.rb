Rails.application.routes.draw do
  get 'oura/index'
  get 'oura/login'
  get 'oura/user'
  get 'pages/index'
  root to: 'pages#index'

  get '/oura/', to: 'oura#index'
  # match "/patients/:id" => "patients#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
