Rails.application.routes.draw do
  resources :admin, only: [:index, :create]
  resources :home, only: :index
  root "home#index"

  mount ActionCable.server => '/cable'
end
