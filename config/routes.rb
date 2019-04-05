Rails.application.routes.draw do
  resources :teams
  root 'home#index'

  post '/service', to: 'home#service'
end
