Rails.application.routes.draw do
  root 'home#index'

  post '/service', to: 'home#service'
end
