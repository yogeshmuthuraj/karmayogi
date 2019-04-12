Rails.application.routes.draw do
  resources :teams, only: :create

  post '/', to: 'home#service'
  get '/', to: 'home#index'
end
