Rails.application.routes.draw do
  root 'home#index'

  post '/plus_one', to: 'karma#add'
end
