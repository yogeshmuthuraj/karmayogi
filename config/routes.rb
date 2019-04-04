Rails.application.routes.draw do
  root 'home#index'

  get '/plus_one', to: 'karma#add'
end
